//
//  NetworkManager.swift
//  Forum
//
//  Created by Антон Тропин on 17.08.2022.
//

import Foundation
import AuthenticationServices


enum NetworkError: Error {
	case invalidURL, noData, decodingError
}


class NetworkManager {
	
	static let shared = NetworkManager()
	private init() {}
	
	private let UID = "b63a06445161397beadebc74b680172eea2827119544d6d73d0d49639bf11465"
	private let SECRET = "900e0c0f4bed9800c3a2f94390355f6d77e4d9263a5016ebccc92f29202548ed"
	private let redirectURL = "forum://forum"
	private let redirectURLHostAllowed = "forum://forum".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
	
	
	func postRequestToken(for delegate: UIViewController, complition: @escaping (Result<String, NetworkError>) -> Void) {
		
		var result  = URLComponents()
			result.scheme = "https"
			result.host = "api.intra.42.fr"
			result.path = "/oauth/authorize"
			result.queryItems = [
				URLQueryItem(name: "client_id", value: UID),
				URLQueryItem(name: "redirect_uri", value: "forum://forum"),
				URLQueryItem(name: "response_type", value: "code"),
				URLQueryItem(name: "scope", value: "public"),
				URLQueryItem(name: "state", value: "4815162342")
			]
		guard let url = result.url else {
			complition(.failure(.invalidURL))
			return
		}

		let webAuthSession = ASWebAuthenticationSession(url: url, callbackURLScheme: redirectURLHostAllowed) { data, error in
			guard let replyData = data else {
				complition(.failure(.noData))
				return
			}
			guard let codeItem = replyData.query else {
				complition(.failure(.decodingError))
				return
			}
			complition(.success(codeItem))
		}
			
		webAuthSession.presentationContextProvider = (delegate as! ASWebAuthenticationPresentationContextProviding)
//        webAuthSession.prefersEphemeralWebBrowserSession = true
		webAuthSession.start()
	}
	
	
	func fetchAccessToken(for code: String, complition: @escaping (Result<TokenData, NetworkError>) -> Void) {

		var codeForToken = code.replacingOccurrences(of: "code=", with: "")
		codeForToken = codeForToken.replacingOccurrences(of: "&state=4815162342", with: "")
		print("Code: \(codeForToken)")
		var result  = URLComponents()
		result.scheme = "https"
		result.host = "api.intra.42.fr"
		result.path = "/oauth/token"
		result.queryItems = [
			URLQueryItem(name: "grant_type", value: "authorization_code"),
			URLQueryItem(name: "client_id", value: self.UID),
			URLQueryItem(name: "client_secret", value: self.SECRET),
			URLQueryItem(name: "code", value: codeForToken),
			URLQueryItem(name: "redirect_uri", value: "forum://forum"),
			URLQueryItem(name: "state", value: "4815162342")
		]
		guard let url = result.url else {
			complition(.failure(.invalidURL))
			return
		}
		
		var resultRequest = URLRequest(url: url)
		resultRequest.httpMethod = "POST"
		URLSession.shared.dataTask(with: resultRequest) { (data, _, error) in
			guard let data = data else {
				complition(.failure(.noData))
				return
			}
			
			do {
				let tokenData = try JSONDecoder().decode(TokenData.self, from: data)
				complition(.success(tokenData))
			} catch {
				complition(.failure(.noData))
			}
			
		}.resume()
	}
	
	
	func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
		guard let url = URL(string: url ?? "") else {
			completion(.failure(.invalidURL))
			return
		}
		DispatchQueue.global().async {
			guard let imageData = try? Data(contentsOf: url) else {
				completion(.failure(.noData))
				return
			}
			DispatchQueue.main.async {
				completion(.success(imageData))
			}
		}
	}
	
	
	func fetch<T: Decodable>(dataType: T.Type, path: String, token: String, complition: @escaping(Result<T, NetworkError>) -> Void) {
		var result  = URLComponents()
		result.scheme = "https"
		result.host = "api.intra.42.fr"
		result.path = path
		
		guard let url = result.url else {
			complition(.failure(.invalidURL))
			return
		}
		
		var resultRequest = URLRequest(url: url)
		resultRequest.httpMethod = "GET"
		resultRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
		
		URLSession.shared.dataTask(with: resultRequest) { data, _, error in
			guard let data = data else {
				complition(.failure(.noData))
				return
			}
			do {
				let type = try JSONDecoder().decode(T.self, from: data)
				DispatchQueue.main.async {
					complition(.success(type))
				}
			} catch {
				complition(.failure(.noData))
			}
		}.resume()
	}
	
	
	func eventRegister<T: Decodable>(dataType: T.Type, token: String, event: Int, user: Int, complition: @escaping (Result<T, NetworkError>) -> Void) {
		var result  = URLComponents()
		result.scheme = "https"
		result.host = "api.intra.42.fr"
		result.path = "/v2/events_users"
		result.queryItems = [
			URLQueryItem(name: "events_user[event_id]", value: "\(event)"),
			URLQueryItem(name: "events_user[userid]", value: "\(user)"),
		]
		

		guard let url = result.url else {
			complition(.failure(.invalidURL))
			return
		}

		var resultRequest = URLRequest(url: url)
		resultRequest.httpMethod = "POST"
		resultRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
		
		print(resultRequest)

		URLSession.shared.dataTask(with: resultRequest) { data, _, error in
			guard let data = data else {
				complition(.failure(.noData))
				return
			}
			do {
				let type = try JSONDecoder().decode(T.self, from: data)
				DispatchQueue.main.async {
					complition(.success(type))
				}
			} catch {
				complition(.failure(.noData))
			}
		}.resume()

	}

		func eventUnregister() {

		}
	
}

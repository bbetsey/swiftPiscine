//
//  APIController.swift
//  Tweets
//
//  Created by Антон Тропин on 04.08.2022.
//

import Foundation


class APIController {

	weak var delegate: APITwitterDelegate?
	private let token: String
	private var tweets: [Tweet] = []
	private let baseUrl: String = "https://api.twitter.com/2/tweets/search/recent"

	init(delegate: APITwitterDelegate?, token: String) {
		self.delegate = delegate
		self.token = token
	}

	func fetchTweets(for searchStr: String) {
		guard let url = URL(string: "\(baseUrl)?query=\(searchStr.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&max_results=100&tweet.fields=created_at&expansions=author_id&user.fields=name") else { return }
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data else {
				DispatchQueue.main.async {
					self.delegate?.errorHandler(for: error! as NSError)
				}
				return
			}

			do {
				let tweetsData = try JSONDecoder().decode(TweetsModel.self, from: data)
				guard let users = tweetsData.includes?.users, let tweetsList = tweetsData.data else {
					self.delegate?.errorHandler(for: NSError(domain: "Can't parse data", code: 0))
					return
				}
				for (index, tweet) in tweetsList.enumerated() {
					if users.count > index {
						self.tweets.append(Tweet(name: users[index].name ?? "", text: tweet.text ?? "", date: tweet.created_at ?? ""))
					}
				}
				DispatchQueue.main.async {
					self.delegate?.receiveTweets(from: self.tweets)
				}
			} catch let error {
				DispatchQueue.main.async {
					self.delegate?.errorHandler(for: error as NSError)
				}
				print(String(describing: error))
			}
		}.resume()
	}
}

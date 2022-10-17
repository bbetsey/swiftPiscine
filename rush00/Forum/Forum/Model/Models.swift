//
//  Models.swift
//  Forum
//
//  Created by Антон Тропин on 10.08.2022.
//

import Foundation

struct TokenData: Codable {
    let accessToken: String?
    
    var accessTokenString: String {
        let result = accessToken ?? ""
        return result
    }
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}

struct CursusInfo: Codable {
    let name: String?
}

struct Cursus: Codable {
    let level: Double?
    let cursus: CursusInfo?
}

struct Campus: Codable {
	let id: Int?
	let name: String?
}

struct UserInfo: Codable {
	let id: Int?
    let login: String?
    let firstName: String?
    let lastName: String?
    let imageURL: String?
    let cursus: [Cursus]?
	let poolMonth: String?
	let poolYear: String?
	let wallet: Int?
	let campus: [Campus]?

    enum CodingKeys: String, CodingKey {
		case id
        case login
        case firstName = "first_name"
        case lastName = "last_name"
        case imageURL = "new_image_url"
        case cursus = "cursus_users"
		case poolMonth = "pool_month"
		case poolYear = "pool_year"
		case wallet
		case campus
    }
}

enum IntraError: LocalizedError {
    case creatingURLError
    case asWebAuthenticationError
    case codeQueryError
    case accessTokenDataError
    case codeUnwrapError
    case infoDataError
    
    
    var errorDescription: String {
        switch self {
        case .creatingURLError:
            return String("creating url error!")
        case .asWebAuthenticationError:
            return String("ASWebAuthentication data error")
        case .codeQueryError:
            return String("No code in query")
        case .accessTokenDataError:
            return String("Access token data reply Error")
        case .codeUnwrapError:
            return String("error with code handeling")
        case .infoDataError:
            return String("Profile data error")
        }
    }
    
}

struct ProfileCursus {
    var level: Double
    var name: String
    
    init() {
        self.level = 0.0
        self.name = String()
    }
    
    init(level: Double, name: String) {
        self.level = level
        self.name = name
    }
}

struct ProfileInfo {
    var firstName: String
    var lastName: String
    var login: String
    var imageUrl: String
    var cursus: [ProfileCursus]
    
    init() {
        self.firstName = String()
        self.lastName = String()
        self.login = String()
        self.imageUrl = String()
        self.cursus = [ProfileCursus]()
    }
}

struct Event: Codable {
	let id: Int?
	let name: String?
	let description: String?
	let location: String?
	let kind: String?
	let maxPeople: Int?
	let nbrSubcribers: Int?
	let beginAt: String?
	let endAt: String?
	let campusIds: [Int]?
	let cursusIds: [Int]?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case description
		case location
		case kind
		case maxPeople = "max_people"
		case nbrSubcribers = "nbr_subscribers"
		case beginAt = "begin_at"
		case endAt = "end_at"
		case campusIds = "campus_ids"
		case cursusIds = "cursus_ids"
	}
	
	static func getCorrectTime(for time: String?) -> String {
		guard let time = time else { return "none" }
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		let date = dateFormatter.date(from: time)
		dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
		return dateFormatter.string(from: date ?? Date())
	}
	
	var startEndLabel: String {
		let begin = Event.getCorrectTime(for: beginAt)
		let end = Event.getCorrectTime(for: endAt)
		return "\(begin) - \(end)"
	}
	
	var nameLabel: String {
		name ?? "none"
	}
	
	var descriptionLabel: String {
		description ?? "none"
	}
	
	var nbrSubscriptionsLabel: String {
		"\(nbrSubcribers ?? 0)"
	}
	
	var maxPeopleLabel: String {
		"\(maxPeople ?? 0)"
	}
	
	var subscripesLabel: String {
		"\(nbrSubscriptionsLabel)/\(maxPeopleLabel)"
	}
	
	var kindLabel: String {
		kind ?? "none"
	}
	
	var locationLabel: String {
		location ?? "none"
	}
}

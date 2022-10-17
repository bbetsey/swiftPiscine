//
//  TweetModel.swift
//  Tweets
//
//  Created by Антон Тропин on 04.08.2022.
//

import Foundation


struct Tweet: CustomStringConvertible {
	let name: String
	let text: String
	let date: String
	
	var description: String {
		"\(name) \(date)\n\(text)\n"
	}
}

struct UserModel: Decodable {
	var id: String?
	var name: String?
	var username: String?
}

struct TweetModel: Decodable {
	var text: String?
	var created_at: String?
}

struct IncludesModel: Decodable {
	var users: [UserModel]?
}

struct TweetsModel: Decodable {
	var data: [TweetModel]?
	var includes: IncludesModel?
}

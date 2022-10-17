//
//  APITwitterDelegate.swift
//  Tweets
//
//  Created by Антон Тропин on 04.08.2022.
//

import Foundation


protocol APITwitterDelegate: AnyObject {
	func receiveTweets(from tweets: [Tweet])
	func errorHandler(for error: NSError)
}

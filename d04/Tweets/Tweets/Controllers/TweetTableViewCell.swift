//
//  TweetTableViewCell.swift
//  Tweets
//
//  Created by Антон Тропин on 04.08.2022.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
	
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var dateLabel: UILabel!
	@IBOutlet var tweetLabel: UILabel!
	
	
	func configure(for tweet: Tweet) {
		nameLabel.text = tweet.name
		dateLabel.text = tweet.date
		tweetLabel.text = tweet.text
	}

}

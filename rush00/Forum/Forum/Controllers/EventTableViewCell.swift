//
//  EventTableViewCell.swift
//  Forum
//
//  Created by Антон Тропин on 17.08.2022.
//

import UIKit

class EventTableViewCell: UITableViewCell {
	
	
	@IBOutlet var typeLabel: UILabel!
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var descriptionLabel: UILabel!
	@IBOutlet var locationLabel: UILabel!
	@IBOutlet var paletteView: UIView!
	@IBOutlet var subscribersLabel: UILabel!
	
	func configureCell(for event: Event) {
		typeLabel.text = event.kindLabel
		nameLabel.text = event.nameLabel
		descriptionLabel.text = event.descriptionLabel
		locationLabel.text = event.locationLabel
		subscribersLabel.text = event.subscripesLabel
	}

}

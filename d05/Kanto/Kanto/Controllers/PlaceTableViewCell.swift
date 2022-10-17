//
//  PlaceTableViewCell.swift
//  Kanto
//
//  Created by Антон Тропин on 07.08.2022.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
	
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var subTitleLabel: UILabel!
	
	func configure(for pin: Pin) {
		titleLabel.text = pin.title
		subTitleLabel.text = pin.subtitle
	}

}

//
//  Extension+UIButton.swift
//  PersonalDiary
//
//  Created by Антон Тропин on 22.08.2022.
//

import UIKit

extension UIButton.Configuration {
	
	public static func custom(with color: UIColor) -> UIButton.Configuration {
		var custom = UIButton.Configuration.filled()
		custom.buttonSize = .large
		custom.titlePadding = 7
		custom.baseBackgroundColor = color
		return custom
	}
	
}

//
//  Extension + UIButton.swift
//  Forum
//
//  Created by Антон Тропин on 17.08.2022.
//

import Foundation
import UIKit


extension UIButton.Configuration {
	
	public static func prussianBlueConf() -> UIButton.Configuration {
		var custom = UIButton.Configuration.filled()
		custom.buttonSize = .large
		custom.titlePadding = 7
		custom.baseBackgroundColor = .prussianBlue
		return custom
	}
	
	public static func imperialRedConf() -> UIButton.Configuration {
		var custom = UIButton.Configuration.filled()
		custom.buttonSize = .large
		custom.titlePadding = 7
		custom.baseBackgroundColor = .imperialRed
		return custom
	}
	
}

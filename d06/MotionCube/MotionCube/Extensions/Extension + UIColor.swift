//
//  Extension + UIColor.swift
//  MotionCube
//
//  Created by Антон Тропин on 08.08.2022.
//

import Foundation
import UIKit


extension UIColor {
	static let richBlack = UIColor(red: 0, green: 18/255, blue: 25/255, alpha: 1)
	static let blueSapphire = UIColor(red: 0, green: 95/255, blue: 115/255, alpha: 1)
	static let viridianGreen = UIColor(red: 10/255, green: 147/255, blue: 150/255, alpha: 1)
	static let middleBlueGreen = UIColor(red: 148/255, green: 210/255, blue: 189/255, alpha: 1)
	static let mediumChampagne = UIColor(red: 233/255, green: 216/255, blue: 166/255, alpha: 1)
	static let camboge = UIColor(red: 238/255, green: 155/255, blue: 0, alpha: 1)
	static let alloyOrange = UIColor(red: 202/255, green: 103/255, blue: 2/255, alpha: 1)
	static let rust = UIColor(red: 187/255, green: 62/255, blue: 3/255, alpha: 1)
	static let rufous = UIColor(red: 174/255, green: 32/255, blue: 18/255, alpha: 1)
	static let rubyRed = UIColor(red: 155/255, green: 34/255, blue: 38/255, alpha: 1)
	
	static func getRandomCustomColor() -> UIColor {
		[
			UIColor.richBlack, UIColor.blueSapphire,
			UIColor.viridianGreen, UIColor.middleBlueGreen,
			UIColor.middleBlueGreen, UIColor.camboge,
			UIColor.rubyRed, UIColor.alloyOrange,
			UIColor.rust, UIColor.rufous
		]
			.randomElement()!
	}
}

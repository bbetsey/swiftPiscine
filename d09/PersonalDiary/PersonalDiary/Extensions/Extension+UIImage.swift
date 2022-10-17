//
//  Extension+UIImage.swift
//  PersonalDiary
//
//  Created by Антон Тропин on 23.08.2022.
//

import UIKit

extension UIImage {
	func fixOrientation() -> UIImage {
		if self.imageOrientation == UIImage.Orientation.up {
			return self
		}
		UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
		self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
		if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
			UIGraphicsEndImageContext()
			return normalizedImage
		} else {
			return self
		}
	}
}

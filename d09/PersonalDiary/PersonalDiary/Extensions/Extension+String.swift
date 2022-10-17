//
//  Extension+String.swift
//  PersonalDiary
//
//  Created by Антон Тропин on 23.08.2022.
//

import Foundation


extension String {
	func localized() -> String {
		NSLocalizedString(
			self,
			tableName: "Localizable",
			bundle: .main,
			value: self,
			comment: self
		)
	}
}

//
//  DeathNoteModel.swift
//  DeathNote
//
//  Created by Антон Тропин on 26.07.2022.
//

import Foundation


struct DeathNoteModel {
	var name: String
	var surname: String
	var date: String
	var description: String
	var fullname: String {
		"\(name) \(surname)"
	}
	
	static func getNotesForTest() -> [DeathNoteModel] {
		[
			DeathNoteModel(
				name: "Rick",
				surname: "Morty",
				date: "06.06.2024 15:42",
				description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam bibendum dolor magna, id volutpat orci facilisis non. Cras convallis ipsum dui, a vehicula nibh ultricies quis. Sed euismod interdum ligula."
			),
			DeathNoteModel(
				name: "Simon",
				surname: "Veldy",
				date: "06.08.2024 11:42",
				description: "Donec tristique elit pretium justo tincidunt bibendum sed et libero. Curabitur lacinia ultricies ante, faucibus mollis mi iaculis sed."
			),
			DeathNoteModel(
				name: "Wolt",
				surname: "Rickly",
				date: "02.09.2029 19:21",
				description: "Curabitur volutpat elit ac ante semper."
			),
			DeathNoteModel(
				name: "John",
				surname: "Mifgrand",
				date: "04.11.2023 21:42",
				description: "Suspendisse accumsan ligula non convallis lacinia. Aliquam ut lectus a quam fermentum laoreet a ac nisi. Quisque tincidunt arcu vitae augue facilisis, non euismod massa ornare. Pellentesque quis consectetur eros. Praesent sit amet arcu urna."
			),
		]
	}
}

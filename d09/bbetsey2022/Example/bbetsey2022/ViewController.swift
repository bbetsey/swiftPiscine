//
//  ViewController.swift
//  bbetsey2022
//
//  Created by 70851552 on 08/22/2022.
//  Copyright (c) 2022 70851552. All rights reserved.
//

import UIKit
import bbetsey2022

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let articleManager = ArticleManager()
		
		// Print saved articles
		print("🛠 SAVED ARTICLES")
		articleManager.getAllArticles().forEach { article in
			print(article)
		}
		print("🛠 END\n")
		
		
		print("🆕 ADD NEW ARTICLES")
		var newArticle: Article
		newArticle = articleManager.newArticle(title: "title 1", content: "ecole 42", language: "en", image: nil)
		print(newArticle, terminator: "\n-----\n")
		newArticle = articleManager.newArticle(title: "title 2 with ecole", content: "Lorem ipsum", language: "en", image: nil)
		print(newArticle, terminator: "\n-----\n")
		newArticle = articleManager.newArticle(title: "title 3", content: "Hello World", language: "fr", image: nil)
		print(newArticle, terminator: "\n-----\n")
		newArticle = articleManager.newArticle(title: "title 4", content: "Swift 5", language: "en", image: nil)
		print(newArticle, terminator: "\n-----\n")
		newArticle = articleManager.newArticle(title: "title 5", content: "UIKit", language: "en", image: nil)
		print(newArticle, terminator: "\n-----\n")
		newArticle = articleManager.newArticle(title: "title 6", content: "SwiftUI with ecole", language: "fr", image: nil)
		print(newArticle, terminator: "\n-----\n")
		print("🆕 END\n")
		
		print("🍣 ALL ARTICLES")
		articleManager.getAllArticles().forEach { article in
			print(article, terminator: "\n-----\n")
		}
		print("🍣 END\n")
		
		
		print("🔎 SEARCH ARTICLES WITH STR 'ecole'")
		articleManager.getArticles(containString: "ecole").forEach { article in
			print(article, terminator: "\n-----\n")
		}
		print("🔎 END\n")
		
		
		print("🔍 SEARCH ARTICLES WITH LANG 'en'")
		articleManager.getArticles(withLang: "en").forEach { article in
			print(article, terminator: "\n-----\n")
		}
		print("🔍 END\n")
		
		
		print("❌ REMOVE ALL ARTICLES\n")
		for article in articleManager.getAllArticles() {
			articleManager.removeArticle(article: article)
		}
		
		print("🍣 ALL ARTICLES")
		articleManager.getAllArticles().forEach { article in
			print(article, terminator: "\n-----\n")
		}
		print("🍣 END\n")
		
		
		print("🆕 ADD ONE ARTICLE WITH SAVE IN PERSISTANCE")
		newArticle = articleManager.newArticle(title: "New Title 007", content: "Nobody", language: "en", image: nil)
		print(newArticle, terminator: "\n-----\n")
		
		print("\n🛟 SAVE\n")
		articleManager.save()
		
		print("🆕 ADD ONE ARTICLE WITHOUT SAVE IN PERSISTANCE")
		newArticle = articleManager.newArticle(title: "Empty title for ninja", content: "🥷", language: "en", image: nil)
		print(newArticle, terminator: "\n-----\n")
	}

}


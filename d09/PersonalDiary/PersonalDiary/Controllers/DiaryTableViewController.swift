//
//  DiaryTableViewController.swift
//  PersonalDiary
//
//  Created by Антон Тропин on 22.08.2022.
//

import UIKit
import bbetsey2022

class DiaryTableViewController: UITableViewController {
	
	private var articles: [Article] = []
	private let articleManager: ArticleManager = ArticleManager()
	private var selectedArticle: Article? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.separatorStyle = .none
		tableView.rowHeight = UITableView.automaticDimension
		updateTVC()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! DiaryTableViewCell
		cell.updateCell(with: articles[indexPath.row])
        return cell
    }
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		true
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedArticle = articles[indexPath.row]
		performSegue(withIdentifier: "article", sender: nil)
	}
	
	override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		.delete
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			articleManager.removeArticle(article: articles[indexPath.row])
			articleManager.save()
			articles.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
	

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let articleVC = segue.destination as? ArticleViewController else { return }
		articleVC.article = selectedArticle
    }
	
	@IBAction func unwind(segue: UIStoryboardSegue) {
		guard let articleVC = segue.source as? ArticleViewController else { return }
		guard let article = articleVC.article else { return }
		
		guard let title = articleVC.titleTF.text, !title.isEmpty,
			  let content = articleVC.contentTV.text, !content.isEmpty,
			  let image = articleVC.coverImage.image else {
			return
		}
		if article.title == "" {
			article.updated_at = article.created_at
		} else {
			article.updated_at = Date()
		}
		article.title = title
		article.content = content
		article.image = UIImage.pngData(image)()
		article.language = Locale.current.languageCode ?? "en"
		articleManager.save()
		updateTVC()
	}
	@IBAction func newArticleTapped(_ sender: Any) {
		let newArticle = articleManager.newArticle(title: "", content: "", language: "", image: nil)
		selectedArticle = newArticle
		performSegue(withIdentifier: "article", sender: nil)
	}
	
}


extension DiaryTableViewController {
	private func updateTVC() {
		articles = articleManager.getArticles(withLang: (Locale.current.languageCode ?? "en"))
		print(Locale.current.languageCode ?? "--")
		tableView.reloadData()
	}
}

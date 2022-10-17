//
//  ArticleManager.swift
//  
//
//  Created by Антон Тропин on 22.08.2022.
//

import CoreData

public class ArticleManager {
	
	public init() {}
	
	private let entityName = "Article"
	
	public let context: NSManagedObjectContext = {
		let bundle = Bundle(for: Article.self)
		let modelURL = bundle.url(forResource: "article", withExtension: "momd")
		guard let model = NSManagedObjectModel(contentsOf: modelURL!) else {
			fatalError("model not found")
		}
		
		let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
		let storeURL = try! FileManager
			.default
			.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
			.appendingPathComponent("article.sqlite")
		
		try! coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL)
		let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
		context.persistentStoreCoordinator = coordinator
		return context
	}()
	
	public func newArticle() -> Article {
		NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! Article
	}
	
	public func newArticle(title: String, content: String, language: String, image: Data?) -> Article {
		var article: Article!
		context.performAndWait {
			let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context)!
			article = Article(entity: entity, insertInto: context)
			article.title = title
			article.content = content
			article.language = language
			article.image = image
			article.created_at = Date()
			article.updated_at = article.created_at
		}
		return article
	}
	
	public func getAllArticles() -> [Article] {
		var articles = [Article]()
		
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		
		do {
			guard let result = try context.fetch(request) as? [Article] else { return articles }
			articles = result
		} catch let error as NSError {
			fatalError("can't fetch articles: \(error.localizedDescription)")
		}
		
		return articles
	}
	
	public func getArticles(withLang lang: String) -> [Article] {
		var articles = [Article]()
		
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		request.predicate = NSPredicate(format: "language==%@", lang)
		
		do {
			guard let result = try context.fetch(request) as? [Article] else { return articles }
			articles = result
		} catch let error as NSError {
			fatalError("can't fetch articles (with lang: \(lang)): \(error.localizedDescription)")
		}
		
		return articles
	}
	
	public func getArticles(containString str: String) -> [Article] {
		var articles = [Article]()
		
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		request.predicate = NSPredicate(format: "content CONTAINS %@ OR title CONTAINS %@", str, str)
		
		do {
			guard let result = try context.fetch(request) as? [Article] else { return articles }
			articles = result
		} catch let error as NSError {
			fatalError("can't fetch articles (with str: \(str)): \(error.localizedDescription)")
		}
		
		return articles
	}
	
	public func save() {
		do {
			try context.save()
		} catch let error {
			print(error.localizedDescription)
		}
	}
	
	public func removeArticle(article: Article) {
		context.delete(article)
	}
}


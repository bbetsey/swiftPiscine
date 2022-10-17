//
//  Article+CoreDataProperties.swift
//  
//
//  Created by Антон Тропин on 22.08.2022.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var language: String?
    @NSManaged public var image: Data?
    @NSManaged public var created_at: Date?
    @NSManaged public var updated_at: Date?
	
	override public var description: String {
		"Title: \(title ?? "nil")\nLanguage: \(language ?? "nil")\nContent: \(content ?? "nil")"
	}

}

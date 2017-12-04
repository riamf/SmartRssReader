//
//  CoreDataStack.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 25/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol StoreProviding {
    var store: StoreHandling { get }
}

extension StoreProviding {
    var store : StoreHandling {
        return (UIApplication.shared.delegate as! AppDelegate).coreDataStack!
    }
    
}

protocol StoreHandling {
    func add(feed: Feed)
    func getAllFeeds() -> [Feed]
}

@objc class ManagedFeed: NSManagedObject {
    @NSManaged var title: String
    @NSManaged var link: String
    @NSManaged var pubDate: String
}

extension ManagedFeed {
    var feed: Feed {
        return Feed(title: title, link: link, pubDate: pubDate)
    }
}

final class CoreDataStack {
    
    var context: NSManagedObjectContext?
    var store: NSPersistentStore?
    var coordinator: NSPersistentStoreCoordinator?

    init() {
        initializeStack()
    }
    
    private func initializeStack() {
        let path = FileManager.documentDirectory + "/AppDataModel.momd"
        var objectModel: NSManagedObjectModel?
        
        do {
            if FileManager.default.fileExists(atPath: path) {
                let dataModel = try Data(contentsOf: URL(fileURLWithPath: path))
                objectModel = NSKeyedUnarchiver.unarchiveObject(with: dataModel) as? NSManagedObjectModel
            }
        } catch {
        }
        
        if objectModel == .none {
            let model = NSManagedObjectModel()
            let feedEntityDescription = NSEntityDescription()
            feedEntityDescription.name = "\(ManagedFeed.self)"
            feedEntityDescription.managedObjectClassName = "SmartRssReader.\(ManagedFeed.self)"
            
            let title = NSAttributeDescription()
            title.name = "title"
            title.attributeType = .stringAttributeType
            title.isOptional = false
            title.isIndexed = true
            
            let link = NSAttributeDescription()
            link.name = "link"
            link.attributeType = .stringAttributeType
            link.isOptional = false
            link.isIndexed = false
            
            let pubDate = NSAttributeDescription()
            pubDate.name = "pubDate"
            pubDate.attributeType = .stringAttributeType
            pubDate.isOptional = false
            pubDate.isIndexed = false
            
            feedEntityDescription.properties = [title, link, pubDate]
            model.entities = [feedEntityDescription]
            
            let modelData = NSKeyedArchiver.archivedData(withRootObject: model)
            try? modelData.write(to: URL(fileURLWithPath: path), options: .atomic)
            
            objectModel = model
        }
        
        if let model = objectModel {
            let persistantCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
            let storePath = FileManager.documentDirectory + "/AppDataDb.sqlite"
            
            if let store = try? persistantCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                        configurationName:"PF_DEFAULT_CONFIGURATION_NAME",
                                                        at: URL(fileURLWithPath: storePath),
                                                        options: nil) {
                
                let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
                context.retainsRegisteredObjects = true
                context.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
                context.persistentStoreCoordinator = persistantCoordinator
                
                self.store = store
                self.coordinator = persistantCoordinator
                self.context = context
            } else {
                fatalError("No store 4 u buddy")
            }
        }
    }
}

extension CoreDataStack: StoreHandling {
    
    func add(feed: Feed) {
        guard let context = context else { return }
        
        let managedFeed = NSEntityDescription.insertNewObject(forEntityName:
            "\(ManagedFeed.self)", into: context) as! ManagedFeed
        
        managedFeed.title = feed.title
        managedFeed.link = feed.link
        managedFeed.pubDate = feed.pubDate

        do {
            try context.save()
        } catch {
            fatalError("fail to save new feed")
        }
    }
    
    func getAllFeeds() -> [Feed] {
        guard let context = context else { return [] }
        
        let request = NSFetchRequest<ManagedFeed>(entityName: "\(ManagedFeed.self)")
        var result: [Feed] = []
        do {
            let managed = try context.fetch(request)
            result = managed.map({ $0.feed })
        } catch {
        }
        return result
    }
}

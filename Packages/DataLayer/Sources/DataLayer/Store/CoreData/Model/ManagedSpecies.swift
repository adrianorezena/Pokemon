//
//  ManagedSpecies.swift
//  Infrastructure
//
//  Created by Adriano Rezena on 03/06/23.
//

import CoreData

@objc(ManagedSpecies)
public class ManagedSpecies: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var imageURL: String
}

extension ManagedSpecies {
    
    public static func get(id: String, in context: NSManagedObjectContext) throws -> ManagedSpecies? {
        let request = NSFetchRequest<ManagedSpecies>(entityName: entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }
    
    public static func count() -> Int {
        return 0
    }
    
    public static func save(in context: NSManagedObjectContext) throws -> ManagedSpecies {
        ManagedSpecies(context: context)
    }
    
}

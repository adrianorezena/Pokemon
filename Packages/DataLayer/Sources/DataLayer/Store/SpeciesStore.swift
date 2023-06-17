//
//  SpeciesStore.swift
//  DataLayer
//
//  Created by Adriano Rezena on 03/06/23.
//

import Infra
import DomainLayer
import Foundation

public protocol SpeciesStore {
    func get(id: String) throws -> Species?
    func save(_ species: Species) throws
    func delete(_ species: Species) throws
}

extension CoreDataStore: SpeciesStore {
    
    public func get(id: String) throws -> Species? {
        try performSync { context in
            Result {
                try ManagedSpecies.get(id: id, in: context).map { Species(name: $0.name, id: $0.id, imageURL: $0.imageURL) }
            }
        }
    }
    
    public func save(_ species: Species) throws {
        try performSync { context in
            Result {
                let managed = try ManagedSpecies.save(in: context)
                managed.id = species.id
                managed.name = species.name
                managed.imageURL = species.imageURL
                
                try context.save()
            }
        }
    }
    
    public func delete(_ species: Species) throws {
        try performSync { context in
            Result {
                if let managed = try ManagedSpecies.get(id: species.id, in: context) {
                    context.delete(managed)
                }
            }
        }
    }

}

//
//  Species.swift
//  DomainLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import Foundation

public struct Species: Equatable {
    public let id: String
    public let name: String
    public let imageURL: String
    
    public init(name: String, id: String, imageURL: String) {
        self.name = name
        self.id = id
        self.imageURL = imageURL
    }
}

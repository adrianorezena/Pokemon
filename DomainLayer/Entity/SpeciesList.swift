//
//  SpeciesList.swift
//  DomainLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import Foundation

public struct SpeciesList: Equatable {
    public struct Species: Equatable {
        public let name: String
        public let url: String
        public let imageURL: String?
        
        public init(name: String, url: String, imageURL: String? = nil) {
            self.name = name
            self.url = url
            self.imageURL = imageURL
        }
    }
    
    let count: Int
    let next: String?
    let previous: String?
    let results: [Species]
    
    public init(count: Int, next: String?, previous: String?, results: [Species]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

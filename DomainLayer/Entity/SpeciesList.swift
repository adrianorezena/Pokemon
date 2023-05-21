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
        
        public init(name: String, url: String) {
            self.name = name
            self.url = url
        }
    }
    
    public let count: Int
    public let next: String?
    public let previous: String?
    public let results: [Species]
    
    public init(count: Int, next: String?, previous: String?, results: [Species]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

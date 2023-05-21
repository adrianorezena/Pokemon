//
//  SpeciesDetail.swift
//  DomainLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import Foundation

public struct SpeciesDetail: Equatable {
    public let chainID: String
    public let color: String
    
    public init(chainID: String, color: String) {
        self.chainID = chainID
        self.color = color
    }
}

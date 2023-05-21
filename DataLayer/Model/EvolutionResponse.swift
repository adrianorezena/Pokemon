//
//  EvolutionResponse.swift
//  DataLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import Foundation

public struct EvolutionResponse: Codable, Equatable {
    let chain: ChainResponse
    let id: Int
}

//
//  PokemonRepositoryProtocol.swift
//  DomainLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import Foundation

public protocol PokemonRepositoryProtocol: AnyObject {
    func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesList, Error>
    func fetchEvolution(id: String) async -> Result<[Species], Error>
    func getSpeciesDetail(id: String) async -> Result<SpeciesDetail, Error>
}

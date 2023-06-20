//
//  FavoriteRepositoryProtocol.swift
//
//
//  Created by Adriano Rezena on 18/06/23.
//

import Foundation

public protocol FavoriteRepositoryProtocol: AnyObject {
    func addFavorite(species: Species) async throws
    func removeFavorite(species: Species) async throws
    func getFavorites() async -> Result<[Species], Error>
}

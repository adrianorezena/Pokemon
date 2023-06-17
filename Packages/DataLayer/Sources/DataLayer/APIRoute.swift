//
//  APIRoute.swift
//  DataLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import Foundation

struct APIRouteError: Error {}

enum APIRoute {
    case getSpeciesList(limit: Int, offset: Int)
    case getSpecies(id: String)
    case getEvolutionChain(id: String)

    private var baseURLString: String { "https://pokeapi.co/api/v2/" }

    var url: URL? {
        switch self {
        case .getSpecies(let id):
            return URL(string: baseURLString + "pokemon-species/" + id)
            
        case .getEvolutionChain(let id):
            return URL(string: baseURLString + "evolution-chain/" + id)
            
        case let .getSpeciesList(limit, offset):
            guard var components: URLComponents = URLComponents(string: baseURLString + "pokemon-species") else {
                return nil
            }
            
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "offset", value: String(offset))
            ]
            
            components.queryItems = queryItems
            
            return components.url
        }
    }
    
}

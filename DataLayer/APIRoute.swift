//
//  APIRoute.swift
//  DataLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import Foundation

enum APIRoute {
    case getSpeciesList(limit: Int, offset: Int)
    case getSpecies(URL)
    case getEvolutionChain(URL)

    private var baseURLString: String { "https://pokeapi.co/api/v2/" }

    var url: URL? {
        switch self {
        case .getSpecies(let url),
                .getEvolutionChain(let url):
            return url
            
        case let .getSpeciesList(limit, offset):
            return URL(
                string: baseURLString + "pokemon-species"
            )?.appending(
                queryItems: [
                    URLQueryItem(name: "limit", value: String(limit)),
                    URLQueryItem(name: "offset", value: String(offset))
                ]
            )
        }
    }
    
}

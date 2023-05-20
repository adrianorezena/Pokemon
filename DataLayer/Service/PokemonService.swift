//
//  PokemonService.swift
//  DataLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import Infrastructure
import Foundation

protocol PokemonServiceProtocol {
    func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesListResponse, Error>
}

final class PokemonService: PokemonServiceProtocol {
    private let client: HTTPClient
        
    public init(client: HTTPClient = URLSessionHTTPClient(session: URLSession.shared)) {
        self.client = client
    }
    
    func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesListResponse, Error> {
        guard let url = APIRoute.getSpeciesList(limit: limit, offset: offset).url else {
            return .failure(NSError(domain: "", code: 0))
        }
        
        return await withCheckedContinuation { continuation in
            client.execute(url: url) { response in
                let response: Result<SpeciesListResponse, Error> = self.mapResponse(result: response)
                
                switch response {
                case .success(let speciesList):
                    continuation.resume(returning: .success(speciesList))
                
                case .failure(let failure):
                    continuation.resume(returning: .failure(failure))
                }
            }
        }
    }
    
    private func mapResponse(result: HTTPClient.HTTPClientResult) -> Result<SpeciesListResponse, Error> {
        switch result {
        case let .success((data, _)):
            do {
                let products = try SpeciesListResponseMapper.map(data)
                return .success(products)
            } catch {
                return .failure(error)
            }
            
        case let .failure(error):
            return .failure(error)
        }
    }
    
}

//
//  PokemonService.swift
//  DataLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import Infra
import Foundation

public protocol PokemonServiceProtocol: AnyObject {
    func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesListResponse, Error>
    func fetchEvolution(id: String) async -> Result<EvolutionResponse, Error>
    func getSpecies(id: String) async -> Result<SpeciesDetailResponse, Error>
}

public final class PokemonService: PokemonServiceProtocol {
    private let client: HTTPClient
        
    public init(client: HTTPClient = URLSessionHTTPClient(session: URLSession.shared)) {
        self.client = client
    }
    
    public func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesListResponse, Error> {
        guard let url = APIRoute.getSpeciesList(limit: limit, offset: offset).url else {
            return .failure(APIRouteError())
        }
        
        return await withCheckedContinuation { continuation in
            client.execute(url: url) { response in
                let response: Result<SpeciesListResponse, Error> = self.mapSpeciesListResponse(result: response)
                
                switch response {
                case .success(let speciesList):
                    continuation.resume(returning: .success(speciesList))
                
                case .failure(let failure):
                    continuation.resume(returning: .failure(failure))
                }
            }
        }
    }
    
    public func getSpecies(id: String) async -> Result<SpeciesDetailResponse, Error> {
        guard let url = APIRoute.getSpecies(id: id).url else {
            return .failure(APIRouteError())
        }
        
        return await withCheckedContinuation { continuation in
            client.execute(url: url) { response in
                let response: Result<SpeciesDetailResponse, Error> = self.mapSpeciesDetailResponse(result: response)
                
                switch response {
                case .success(let speciesDetail):
                    continuation.resume(returning: .success(speciesDetail))

                case .failure(let failure):
                    continuation.resume(returning: .failure(failure))
                }
            }
        }
    }
    
    public func fetchEvolution(id: String) async -> Result<EvolutionResponse, Error> {
        guard let url = APIRoute.getEvolutionChain(id: id).url else {
            return .failure(APIRouteError())
        }
        
        return await withCheckedContinuation { continuation in
            client.execute(url: url) { response in
                let response: Result<EvolutionResponse, Error> = self.mapEvolutionResponse(result: response)
                
                switch response {
                case .success(let evolution):
                    continuation.resume(returning: .success(evolution))
                    
                case .failure(let failure):
                    continuation.resume(returning: .failure(failure))
                }
            }
        }

    }
    
    // MARK: - Helper
    private func mapEvolutionResponse(result: HTTPClient.HTTPClientResult) -> Result<EvolutionResponse, Error> {
        switch result {
        case let .success((data, _)):
            do {
                let mappedResponse = try EvolutionResponseMapper.map(data)
                return .success(mappedResponse)
            } catch {
                return .failure(error)
            }
            
        case let .failure(error):
            return .failure(error)
        }
    }
    
    private func mapSpeciesListResponse(result: HTTPClient.HTTPClientResult) -> Result<SpeciesListResponse, Error> {
        switch result {
        case let .success((data, _)):
            do {
                let mappedResponse = try SpeciesListResponseMapper.map(data)
                return .success(mappedResponse)
            } catch {
                return .failure(error)
            }
            
        case let .failure(error):
            return .failure(error)
        }
    }
    
    private func mapSpeciesDetailResponse(result: HTTPClient.HTTPClientResult) -> Result<SpeciesDetailResponse, Error> {
        switch result {
        case let .success((data, _)):
            do {
                let mappedResponse = try SpeciesDetailResponseMapper.map(data)
                return .success(mappedResponse)
            } catch {
                return .failure(error)
            }
            
        case let .failure(error):
            return .failure(error)
        }
    }
    
}

//
//  DetailViewModel.swift
//  Pokemon
//
//  Created by Adriano Rezena on 21/05/23.
//

import DomainLayer
import Foundation

protocol DetailViewModelProtocol {
    var species: SpeciesList.Species { get set }
    var imageURL: String? { get set }
}

final class DetailViewModel: DetailViewModelProtocol {
    var species: SpeciesList.Species
    var imageURL: String?
    
    init(species: SpeciesList.Species, imageURL: String?) {
        self.species = species
        self.imageURL = imageURL
    }
}

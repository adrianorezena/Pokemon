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
}

final class DetailViewModel: DetailViewModelProtocol {
    var species: SpeciesList.Species
    
    init(species: SpeciesList.Species) {
        self.species = species
    }
}

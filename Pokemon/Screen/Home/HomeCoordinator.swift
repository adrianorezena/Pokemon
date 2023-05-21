//
//  HomeCoordinator.swift
//  Pokemon
//
//  Created by Adriano Rezena on 21/05/23.
//

import DataLayer
import DomainLayer
import UIKit

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let pokemonRepository: PokemonRepository = PokemonRepository()
        let vm: HomeViewModel = HomeViewModel(pokemonRepository: pokemonRepository)
        let vc = HomeViewController(viewModel: vm)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openDetails(species: SpeciesList.Species, imageURL: String?) {
        let vm: DetailViewModel = DetailViewModel(species: species, imageURL: imageURL)
        let vc: DetailViewController = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}

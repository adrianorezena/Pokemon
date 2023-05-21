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
        let repository: PokemonRepository = PokemonRepository()
        let useCase: ListPokemonUseCase = ListPokemonUseCase(pokemonRepository: repository)
        let vm: HomeViewModel = HomeViewModel(pokemonUseCase: useCase)
        let vc = HomeViewController(viewModel: vm)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openDetails(species: Species) {
        let repository: PokemonRepository = PokemonRepository()
        let useCase: EvolutionPokemonUseCase = EvolutionPokemonUseCase(pokemonRepository: repository)
        let vm: DetailViewModel = DetailViewModel(evolutionUseCase: useCase, species: species)
        let vc: DetailViewController = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}

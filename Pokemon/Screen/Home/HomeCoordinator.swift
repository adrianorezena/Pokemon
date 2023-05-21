//
//  HomeCoordinator.swift
//  Pokemon
//
//  Created by Adriano Rezena on 21/05/23.
//

import DataLayer
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
}

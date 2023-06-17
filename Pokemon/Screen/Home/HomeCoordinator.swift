//
//  HomeCoordinator.swift
//  Pokemon
//
//  Created by Adriano Rezena on 21/05/23.
//

import CoreData
import DataLayer
import DomainLayer
import UIKit

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController = UITabBarController()
    
    private lazy var store: SpeciesStore = {
        let databasePath = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("store.sqlite")
        return try! CoreDataStore(storeURL: databasePath)
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let repository: PokemonRepository = PokemonRepository(speciesStore: store)
        let useCase: PokemonListUseCase = PokemonListUseCase(pokemonRepository: repository)
        let vm: HomeViewModel = HomeViewModel(pokemonUseCase: useCase)
        let vc = HomeViewController(viewModel: vm)
        vc.coordinator = self
        vc.tabBarItem.title = "Home"
        vc.tabBarItem.image = UIImage(systemName: "house")
        
        let favorites = UIViewController()
        favorites.tabBarItem.title = "Favorites"
        favorites.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        tabBarController.viewControllers = [vc, favorites]
        tabBarController.selectedIndex = 0
        
        navigationController.pushViewController(tabBarController, animated: false)
    }
    
    func openDetails(species: Species) {
        let repository: PokemonRepository = PokemonRepository(speciesStore: store)
        let useCase: PokemonEvolutionUseCase = PokemonEvolutionUseCase(pokemonRepository: repository)
        let vm: DetailViewModel = DetailViewModel(evolutionUseCase: useCase, species: species)
        let vc: DetailViewController = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}

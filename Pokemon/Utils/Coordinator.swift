//
//  Coordinator.swift
//  Pokemon
//
//  Created by Adriano Rezena on 21/05/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

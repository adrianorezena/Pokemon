//
//  ViewController.swift
//  Pokemon
//
//  Created by Adriano Rezena on 19/05/23.
//

import DomainLayer
import UIKit

final class HomeViewController: UIViewController {
    let viewModel: HomeViewModelProtocol
    weak var coordinator: HomeCoordinator?
    
    private let tableView: UITableView = {
        let cellPadding: CGFloat = 16
        let cellHeight: CGFloat = 40
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = cellHeight + cellPadding + cellPadding
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reuseIdentifier)
        return tableView
    }()
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        viewModel.fetchSpecies { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.species.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseIdentifier) as! HomeCell
        let species = viewModel.species[indexPath.row]
        cell.nameLabel.text = species.name
        cell.pokemonImageView.setImage(urlString: String(format: URLs.pokemonImage, String(indexPath.row + 1)))
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.species.count - 10 {
            viewModel.fetchSpecies { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
}

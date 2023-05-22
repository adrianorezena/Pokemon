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
    
    private let errorLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupViews() {
        navigationItem.title = "Pokemon List"
        setupTableView()
        setupErrorLabel()
    }
    
    private func setupTableView() {
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
    
    private func setupErrorLabel() {
        tableView.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            errorLabel.widthAnchor.constraint(equalTo: tableView.widthAnchor, constant: -40)
        ])
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        viewModel.fetchSpecies { [weak self] in
            self?.errorLabel.text = ""
            
            if let fetchError = self?.viewModel.fetchError {
                self?.errorLabel.text = fetchError
            }
            
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
        cell.pokemonImageView.setImage(urlString: species.imageURL)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let species: Species = viewModel.species[indexPath.row]
        coordinator?.openDetails(species: species)
    }
    
}

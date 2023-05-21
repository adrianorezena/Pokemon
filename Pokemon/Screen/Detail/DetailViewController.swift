//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Adriano Rezena on 21/05/23.
//

import UIKit

final class DetailViewController: UIViewController {
    let viewModel: DetailViewModelProtocol
    
    private let pokemonImageView: AsyncImageView = {
        let imageView = AsyncImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let evolutionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .label
        label.text = "Evolution"
        return label
    }()
    
    private let tableView: UITableView = {
        let cellPadding: CGFloat = 16
        let cellHeight: CGFloat = 40
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = cellHeight + cellPadding + cellPadding
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reuseIdentifier)
        return tableView
    }()

    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupViews()
        viewModel.fetchEvolution { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupViews() {
        navigationItem.title = viewModel.species.name.uppercased()
        view.backgroundColor = .systemBackground
        
        setupPokemonImage()
        setupEvolutionLabel()
        setupTableView()
    }
    
    private func setupPokemonImage() {
        view.addSubview(pokemonImageView)
        
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 150),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        pokemonImageView.setImage(urlString: viewModel.species.imageURL)
    }
    
    private func setupEvolutionLabel() {
        view.addSubview(evolutionLabel)
        
        NSLayoutConstraint.activate([
            evolutionLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 20),
            evolutionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            evolutionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            evolutionLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: evolutionLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        tableView.dataSource = self
    }
    
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.evolution.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseIdentifier) as! HomeCell
        let evolution = viewModel.evolution[indexPath.row]
        cell.nameLabel.text = evolution.name
        cell.pokemonImageView.setImage(urlString: evolution.imageURL)
        return cell
    }
    
}

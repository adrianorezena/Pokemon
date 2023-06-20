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
        let cellPadding: CGFloat = 8
        let cellHeight: CGFloat = 50
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reuseIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let errorLabel: ErrorLabel = {
        let label: ErrorLabel = ErrorLabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
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
        setupRefreshControl()
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
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(onRefreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchSpecies()
    }
    
    // MARK: - Other
    private func fetchSpecies() {
        self.errorLabel.text = ""
        
        viewModel.fetchSpecies { [weak self] in
            if let fetchError = self?.viewModel.fetchError {
                self?.errorLabel.text = fetchError
            }
            
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func fetchModeSpecies() {
        viewModel.fetchMoreSpecies { [weak self] newSpecies in
            guard let self = self else { return }
            
            let indexPaths: [IndexPath] = (viewModel.species.count - newSpecies.count..<viewModel.species.count).map { IndexPath(row: $0, section: 0) }
            
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indexPaths, with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    @objc
    private func onRefreshData() {
        fetchSpecies()
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
        cell.configure(species: species, isFavorite: false)
        cell.delegate = self
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.species.count - 10 {
            fetchModeSpecies()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let species: Species = viewModel.species[indexPath.row]
        coordinator?.openDetails(species: species)
    }
    
}

// MARK: - HomeCellDelegate
extension HomeViewController: HomeCellDelegate {
    func onTapFavoriteButton(species: Species, isFavorite: Bool) {
    }
}

//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Adriano Rezena on 21/05/23.
//

import UIKit

final class DetailViewController: UIViewController {
    let viewModel: DetailViewModelProtocol
    
    let pokemonImageView: AsyncImageView = {
        let imageView = AsyncImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
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
    }
    
    private func setupViews() {
        navigationItem.title = viewModel.species.name.uppercased()
        view.backgroundColor = .white
        
        view.addSubview(pokemonImageView)
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 150),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        pokemonImageView.setImage(urlString: viewModel.imageURL)
        
    }
}

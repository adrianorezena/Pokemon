//
//  HomeCell.swift
//  Pokemon
//
//  Created by Adriano Rezena on 20/05/23.
//

import UIKit

class HomeCell: UITableViewCell {
    static let reuseIdentifier = "HomeCell"
    
    let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    private func setupView() {
        addSubview(pokemonImageView)
        NSLayoutConstraint.activate([
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            pokemonImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 40),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: pokemonImageView.centerYAnchor)
        ])
    }
    
}

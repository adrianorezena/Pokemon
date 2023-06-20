//
//  HomeCell.swift
//  Pokemon
//
//  Created by Adriano Rezena on 20/05/23.
//

import DomainLayer
import UIKit

protocol HomeCellDelegate: AnyObject {
    func onTapFavoriteButton(species: Species, isFavorite: Bool)
}

class HomeCell: UITableViewCell {
    static let reuseIdentifier = "HomeCell"
    weak var delegate: HomeCellDelegate?
    
    private var species: Species?
    
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(UIImage(systemName: isFavorite ? "heart.fill" : "heart" ), for: .normal)
        }
    }
    
    let pokemonImageView: AsyncImageView = {
        let imageView = AsyncImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        button.addTarget(self, action: #selector(onTapFavoriteButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none
        
        contentView.addSubview(pokemonImageView)
        NSLayoutConstraint.activate([
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            pokemonImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 50),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        contentView.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: pokemonImageView.centerYAnchor)
        ])

        // self.debugSize()
    }
    
    @objc private func onTapFavoriteButton(sender: UIButton) {
        guard let species = species else { return }
        
        isFavorite.toggle()
        delegate?.onTapFavoriteButton(species: species, isFavorite: isFavorite)
    }
    
    func configure(species: Species, isFavorite: Bool) {
        nameLabel.text = species.name
        pokemonImageView.setImage(urlString: species.imageURL)
        self.isFavorite = isFavorite
        self.species = species
    }
    
}

extension UIView {
    func debugSize() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            for view in self.subviews {
                // view.backgroundColor = randomColor()
                let dashedBorderLayer = CAShapeLayer()
                dashedBorderLayer.strokeColor = UIColor.yellow.cgColor
                dashedBorderLayer.lineDashPattern = [2, 2] // Define o padrão dos traços e espaços
                dashedBorderLayer.frame = view.bounds
                dashedBorderLayer.fillColor = nil
                dashedBorderLayer.path = UIBezierPath(rect: view.bounds).cgPath
                dashedBorderLayer.lineWidth = 1
                view.layer.addSublayer(dashedBorderLayer)
            }
        }
        
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let alpha = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

}

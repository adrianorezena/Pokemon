//
//  ErrorLabel.swift
//  Pokemon
//
//  Created by Adriano Rezena on 18/06/23.
//

import UIKit

class ErrorLabel: UILabel {
    
    // MARK: - init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    private func commonInit() {
        textColor = .red
        font = .boldSystemFont(ofSize: 16)
        numberOfLines = 0
        textAlignment = .center
    }
    
    // MARK: - lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

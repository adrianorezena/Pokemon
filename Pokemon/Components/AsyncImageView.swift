//
//  AsyncImageView.swift
//  Pokemon
//
//  Created by Adriano Rezena on 21/05/23.
//

import Kingfisher
import UIKit

final class AsyncImageView: UIImageView {

    func setImage(url: URL?) {
        self.kf.setImage(with: url)
    }
    
    func setImage(urlString: String?) {
        if let urlString = urlString, let url: URL = URL(string: urlString) {
            self.kf.setImage(with: url)
        } else {
            self.image = nil
        }
    }
    
}

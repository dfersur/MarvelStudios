//
//  UIImageView + Additions.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 11/6/22.
//  Copyright © 2022 MynSoftware. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// Carga imagen mediante url
    /// - Parameter url: URL de la imagen
    func load(url: String?) {
        
        guard let newUrl = url, let url = URL(string: newUrl) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }

    }
    
}

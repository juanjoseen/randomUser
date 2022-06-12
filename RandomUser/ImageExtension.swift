//
//  ImageExtension.swift
//  RandomUser
//
//  Created by Juan Jose Elias Navarro on 11/06/22.
//

import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String, completion: @escaping () -> Void) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                    completion()
                }
            }
        }
    }
}

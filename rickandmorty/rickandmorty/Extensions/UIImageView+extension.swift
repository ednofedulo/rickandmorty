//
//  UIImageView+extension.swift
//  rickandmorty
//
//  Created by Edno Fedulo on 06/12/20.
//  Copyright © 2020 Edno Fedulo. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(from url: URL, dimension: CGFloat? = nil) {
        
        if let dimension = dimension {
            self.image = UIImage(systemName: "clock")?.resize(dimension)
        } else {
            self.image = UIImage(systemName: "clock")
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            
            guard error == nil else { return }
            guard let data = data else { return }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let dimension = dimension {
                        self.image = image.resize(dimension)
                    } else {
                        self.image = image
                    }
                }
            }
        })
        
        task.resume()
    }
}

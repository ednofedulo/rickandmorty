//
//  UIImage+extension.swift
//  rickandmorty
//
//  Created by Edno Fedulo on 06/12/20.
//  Copyright © 2020 Edno Fedulo. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func resize(_ dimension: CGFloat) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        
        let size = self.size
        let aspectRatio =  size.width/size.height
        
        if aspectRatio > 1 {
            width = dimension
            height = dimension / aspectRatio
        } else {
            height = dimension
            width = dimension * aspectRatio
        }
        
        let renderFormat = UIGraphicsImageRendererFormat.default()
        renderFormat.opaque = false
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
        newImage = renderer.image {
            (context) in
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        
        return newImage
    }
    
    
}

//
//  UIImageExtension.swift
//  MusicApp
//
//  Created by HungDo on 7/25/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import UIKit

extension UIImage {
    
    func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
        draw(in: rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setBlendMode(.sourceIn)
        context?.setFillColor(color.cgColor)
        context?.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

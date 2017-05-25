//
//  CircleStrokeButton.swift
//  MusicApp
//
//  Created by HungDo on 7/25/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import UIKit

class CircleStrokeButton: UIButton {
    
    var circleColor = UIColor.white.withAlphaComponent(0.8)
    var circleWith: CGFloat = 2.0 { didSet { setNeedsDisplay() } }
    var circleOffset: CGFloat = 0.9
    
    var image: UIImage? { didSet { setNeedsDisplay() } }
    
    var imageColor = UIColor.white
    var imageOffset: CGFloat = 0.7 { didSet { setNeedsDisplay() } }
    
    fileprivate var radius: CGFloat {
        return min(self.bounds.size.width, self.bounds.size.height) / 2
    }
    
    fileprivate lazy var circleCenter: CGPoint = {
        return CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }()
    
    fileprivate func pathForCircle() -> UIBezierPath {
        circleColor.set()
        let path = UIBezierPath(arcCenter: circleCenter, radius: radius * circleOffset, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: false)
        path.lineWidth = circleWith
        return path
    }
    
    fileprivate func drawImage() {
        guard let image = image else { return }
        let otherImage = image.imageWithColor(imageColor)
        
        let offset = radius * imageOffset
        let origin = CGPoint(x: self.bounds.midX - offset, y: self.bounds.midY - offset)
        let size = CGSize(width: offset * 2, height: offset * 2)
        
        imageColor.set()
        otherImage.draw(in: CGRect(origin: origin, size: size))
    }
    
    override func draw(_ rect: CGRect) {
        pathForCircle().stroke()
        drawImage()
    }

}

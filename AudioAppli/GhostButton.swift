//
//  GhostButton.swift
//  MusicApp
//
//  Created by HungDo on 7/24/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import UIKit

class GhostButton: UIButton {
    
    var color = UIColor.blue {
        didSet {
            self.tintColor = color
            self.layer.borderColor = color.cgColor
        }
    }
    
    var borderWidth: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    var cornerRadius: CGFloat = 2 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.tintColor = color
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
    
    func ghostButtonWithColor(_ color: UIColor) -> GhostButton {
        self.color = color
        return self
    }
    
    func ghostButtonWithBorderWidth(_ width: CGFloat) -> GhostButton {
        self.borderWidth = width
        return self
    }
    
    func ghostButtonWithCornerRadius(_ radius: CGFloat) -> GhostButton {
        self.cornerRadius = radius
        return self
    }
    
}

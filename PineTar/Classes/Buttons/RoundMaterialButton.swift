//
//  RoundedMaterialButton.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/2/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class RoundMaterialButton: MaterialButton {
    @IBInspectable var buttonImage: UIImage?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    private func setup() {
        self.addCornerRadius(radius: self.bounds.width/2)
        self.addShadow()
        self.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        if ThemeManager.buttonsAreHighlightColor {
            self.tintColor = ThemeManager.textHighlightColor
        } else {
            self.tintColor = ThemeManager.highlightColor
        }
        
        if let image = buttonImage {
            self.setImage(image, for: .normal)
        } else {
            let image = UIImage.init(named: "plus", in: Bundle(for: type(of: self)), compatibleWith: nil)
            self.setImage(image, for: .normal)
        }
    }
}

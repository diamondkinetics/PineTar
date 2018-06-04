//
//  PineTar
//  RoundedMaterialButton.swift
//
//  Created by Tommy Martin on 5/2/18.
//  Copyright (c) 2018-present, Diamond Kinetics
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
        
        if hasShadow {
            self.addShadow()
        }
        
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

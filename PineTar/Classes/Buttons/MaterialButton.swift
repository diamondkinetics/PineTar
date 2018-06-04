//
//  PineTar
//  MaterialButton.swift
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
public class MaterialButton: UIButton {
    @IBInspectable var hasShadow: Bool = true
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        if ThemeManager.buttonsAreHighlightColor {
            self.backgroundColor = ThemeManager.highlightColor
        } else {
            self.backgroundColor = ThemeManager.primaryColor
        }
        
        self.setTitleColor(ThemeManager.textHighlightColor, for: .normal)
        self.titleLabel?.font = ThemeManager.font.withSize(20)
        addCornerRadius(radius: 4)
        
        if hasShadow {
            addShadow()
        }
        
        self.addTarget(self, action: #selector(pressDown), for: UIControlEvents.touchDown)
        self.addTarget(self, action: #selector(pressUp), for: UIControlEvents.touchCancel)
        self.addTarget(self, action: #selector(pressUp), for: UIControlEvents.touchUpInside)
    }
    
    func setText(text: String) {
        self.setTitle(text, for: .normal)
    }
    
    @objc func pressDown() {
        UIView.animate(withDuration: 0.5, animations: {
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.layer.shadowOpacity = 0.5
            self.layer.shadowColor = UIColor.black.cgColor
        })
    }
    
    @objc func pressUp() {
        self.addShadow()
    }
}

//
//  MaterialButton.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/2/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
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

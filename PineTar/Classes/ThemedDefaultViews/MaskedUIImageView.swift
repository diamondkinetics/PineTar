//
//  MaskedUIImage.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/10/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class MaskedUIImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var maskColor: UIColor?
    @IBInspectable var maskAlpha: CGFloat = 1.0
    private var mv: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mv?.frame = self.frame
    }
    
    private func setup() {
        addCornerRadius(radius: cornerRadius)
        if let maskColor = maskColor {
            let view = UIView(frame: self.frame)
            view.backgroundColor = maskColor.withAlphaComponent(maskAlpha)
            self.mask = view
            self.mv = view
        }
    }
}

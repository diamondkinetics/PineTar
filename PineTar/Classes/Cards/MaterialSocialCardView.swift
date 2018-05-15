//
//  MaterialSocialCardView.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/3/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

// TODO: Fix - No longer rendering in storyboard
@IBDesignable
public class MaterialSocialCardView: MaterialCardView {
    override public func awakeFromNib() {
        setup()
        super.awakeFromNib()
    }
    
    override public func prepareForInterfaceBuilder() {
        setup()
        super.prepareForInterfaceBuilder()
    }
    
    private func setup() {
        configureWithDefaults()
    }
    
    private func configureWithDefaults() {
        if image == nil {
            image = UIImage(named: "justin", in: Bundle(for: type(of: self)), compatibleWith: nil)
        }
        
        if divideImage == nil {
            // TODO: Put an image in here
//            divideImage = UIImage(named: "phinatic", in: Bundle(for: type(of: self)), compatibleWith: nil)
            divideImage = UIImage()
        }
        
        imageStyle = imageStyle == -1 ? ImageStyle.circle.rawValue : imageStyle
        imageAlignment = imageAlignment == -1 ? ImageAlignment.topLeft.rawValue : imageAlignment
        imageHeight = imageHeight == -1 ? 35 : imageHeight
        imageWidth = imageWidth == -1 ? 35 : imageWidth
        header = header == nil ? "Philly Phanatic Eats a Hot Dog" : header
        headerSize = headerSize == -1 ? 14 : headerSize
        subheader = subheader == nil ? "Tom Martin" : subheader
        subheaderSize = subheaderSize == -1 ? 10 : subheaderSize
        headerHorzOffset = headerHorzOffset == -1 ? 55 : headerHorzOffset
        
        divideHeight = divideHeight == -1 ? 140 : divideHeight
        divideOffset = divideOffset == -1 ? 55 : divideOffset
        cornerRadius = cornerRadius == -1 ? 4 : cornerRadius
        
        contentDescription = contentDescription == nil ? "In an interesting turn of events, Philly Phanatic, a resident of South Philadelphia consumes questionable meat" : contentDescription
    }
}

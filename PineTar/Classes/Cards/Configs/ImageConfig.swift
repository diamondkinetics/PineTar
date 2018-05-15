//
//  ImageConfig.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/8/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

public struct ImageConfig {
    var image: UIImage?
    var imageHeight: CGFloat?
    var imageWidth: CGFloat?
    var imageAlignment: Int?
    var imageStyle: Int?
    var imageVertOffset: Int?
    var imageHorzOffset: Int?
    
    public init(image: UIImage? = nil, imageHeight: CGFloat? = nil, imageWidth: CGFloat? = nil, imageAlignment: Int? = nil, imageStyle: Int? = nil, imageVertOffset: Int? = nil, imageHorzOffset: Int? = nil) {
        self.image = image
        self.imageHeight = imageHeight
        self.imageAlignment = imageAlignment
        self.imageStyle = imageStyle
        self.imageVertOffset = imageVertOffset
        self.imageHorzOffset = imageHorzOffset
    }
    
    public init(card: MaterialCardView) {
        self.image = card.image
        self.imageHeight = card.imageHeight
        self.imageWidth = card.imageWidth
        self.imageAlignment = card.imageAlignment
        self.imageStyle = card.imageStyle
        self.imageVertOffset = card.imageVertOffset
        self.imageHorzOffset = card.imageHorzOffset
    }
    
    public func copyWithUpdates(image: UIImage? = nil, imageHeight: CGFloat? = nil, imageWidth: CGFloat? = nil, imageAlignment: Int? = nil, imageStyle: Int? = nil, imageVertOffset: Int? = nil, imageHorzOffset: Int? = nil) -> ImageConfig {
        
        var copy = self
        
        if let image = image {copy.image = image}
        if let imageHeight = imageHeight {copy.imageHeight = imageHeight}
        if let imageWidth = imageWidth {copy.imageWidth = imageWidth}
        if let imageAlignment = imageAlignment {copy.imageAlignment = imageAlignment}
        if let imageStyle = imageStyle {copy.imageStyle = imageStyle}
        if let imageVertOffset = imageVertOffset {copy.imageVertOffset = imageVertOffset}
        if let imageHorzOffset = imageHorzOffset {copy.imageHorzOffset = imageHorzOffset}
        
        return copy
    }
}

//
//  DividerConfig.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/8/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

public struct DividerConfig {
    var divideOffset: CGFloat?
    var divideHeight: CGFloat?
    var divideColor: UIColor?
    var divideImage: UIImage?
    
    public init(divideOffset: CGFloat? = nil, divideHeight: CGFloat? = nil, divideColor: UIColor? = nil, divideImage: UIImage? = nil) {
        self.divideOffset = divideOffset
        self.divideHeight = divideHeight
        self.divideColor = divideColor
        self.divideImage = divideImage
    }
    
    public init(card: MaterialCardView) {
        self.divideOffset = card.divideOffset
        self.divideHeight = card.divideHeight
        self.divideColor = card.divideColor
        self.divideImage = card.divideImage
    }
    
    public func copyWithUpdates(divideOffset: CGFloat? = nil, divideHeight: CGFloat? = nil, divideColor: UIColor? = nil, divideImage: UIImage? = nil) -> DividerConfig {
        var copy = self
        
        if let divideOffset = divideOffset {copy.divideOffset = divideOffset}
        if let divideHeight = divideHeight {copy.divideHeight = divideHeight}
        if let divideColor = divideColor {copy.divideColor = divideColor}
        if let divideImage = divideImage {copy.divideImage = divideImage}
        
        return copy
    }
}

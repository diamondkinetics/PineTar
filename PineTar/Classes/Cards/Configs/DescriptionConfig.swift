//
//  DescriptionConfig.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/8/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

public struct DescriptionConfig {
    var contentDescription: String?
    var contentDescriptionOffset: Int?
    var contentDescriptionSize: CGFloat?
    var contentDescriptionColor: UIColor?
    
    public init(contentDescription: String? = nil, contentDescriptionOffset: Int? = nil, contentDescriptionSize: CGFloat? = nil, contentDescriptionColor: UIColor? = nil) {
        self.contentDescription = contentDescription
        self.contentDescriptionOffset = contentDescriptionOffset
        self.contentDescriptionSize = contentDescriptionSize
        self.contentDescriptionColor = contentDescriptionColor
    }
    
    public init(card: MaterialCardView) {
        self.contentDescription = card.contentDescription
        self.contentDescriptionOffset = card.contentDescriptionOffset
        self.contentDescriptionSize = card.contentDescriptionSize
        self.contentDescriptionColor = card.contentDescriptionColor
    }
    
    public func copyWithUpdates(contentDescription: String? = nil, contentDescriptionOffset: Int? = nil, contentDescriptionSize: CGFloat? = nil, contentDescriptionColor: UIColor? = nil) -> DescriptionConfig {
        var copy = self
        
        if let contentDescription = contentDescription {copy.contentDescription = contentDescription}
        if let contentDescriptionOffset = contentDescriptionOffset {copy.contentDescriptionOffset = contentDescriptionOffset}
        if let contentDescriptionSize = contentDescriptionSize {copy.contentDescriptionSize = contentDescriptionSize}
        if let contentDescriptionColor = contentDescriptionColor {copy.contentDescriptionColor = contentDescriptionColor}
        
        return copy
    }
}

//
//  MaterialCardConfig.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/8/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

// TODO: Move configs to Enums as opposed to the raw value

// Unfortunately, I beleive that this cannot be used to configure all Material cells because we want to use IBInspectable
public struct MaterialCardConfig {
    var cornerRadius: CGFloat?
    var backgroundColor: UIColor?
    var dividerConfig: DividerConfig?
    var imageConfig: ImageConfig?
    var headerConfig: HeaderConfig?
    var descriptionConfig: DescriptionConfig?

    public init(cornerRadius: CGFloat? = nil, backgroundColor: UIColor? = nil, dividerConfig: DividerConfig? = nil, imageConfig: ImageConfig? = nil, headerConfig: HeaderConfig? = nil, descriptionConfig: DescriptionConfig? = nil) {
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.dividerConfig = dividerConfig
        self.imageConfig = imageConfig
        self.headerConfig = headerConfig
        self.descriptionConfig = descriptionConfig
    }

    public init(card: MaterialCardView) {
        self.cornerRadius = card.cornerRadius
        self.backgroundColor = card.backgroundColor
        self.dividerConfig = DividerConfig(card: card)
        self.imageConfig = ImageConfig(card: card)
        self.headerConfig = HeaderConfig(card: card)
        self.descriptionConfig = DescriptionConfig(card: card)
    }

    // TODO: If they wish to update by setting something to nil, this will not work
    public func copyWithUpdates(cornerRadius: CGFloat? = nil, dividerConfig: DividerConfig? = nil, imageConfig: ImageConfig? = nil, headerConfig: HeaderConfig? = nil, descriptionConfig: DescriptionConfig? = nil) -> MaterialCardConfig {
        
        // The wonderful world of structs
        var copy = self
        
        if let cornerRadius = cornerRadius {copy.cornerRadius = cornerRadius}
        if let dividerConfig = dividerConfig {copy.dividerConfig = dividerConfig}
        if let imageConfig = imageConfig {copy.imageConfig = imageConfig}
        if let headerConfig = headerConfig {copy.headerConfig = headerConfig}
        if let descriptionConfig = descriptionConfig {copy.descriptionConfig = descriptionConfig}
        
        return copy
    }

}

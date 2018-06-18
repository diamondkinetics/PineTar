//
//  MaterialCardConfig.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/8/18.
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

// TODO: Move configs to Enums as opposed to the raw value

// Unfortunately, I beleive that this cannot be used to configure all Material cells because we want to use IBInspectable
public struct MaterialCardConfig {
    var cornerRadius: CGFloat?
    var backgroundColor: UIColor?
    var dividerConfig: DividerConfig?
    var imageConfig: ImageConfig?
    var headerConfig: HeaderConfig?
    var descriptionConfig: DescriptionConfig?
    var customViewConfig: CustomViewConfig?

    public init(cornerRadius: CGFloat? = nil, backgroundColor: UIColor? = nil, dividerConfig: DividerConfig? = nil, imageConfig: ImageConfig? = nil, headerConfig: HeaderConfig? = nil, descriptionConfig: DescriptionConfig? = nil, customViewConfig: CustomViewConfig? = nil) {
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.dividerConfig = dividerConfig
        self.imageConfig = imageConfig
        self.headerConfig = headerConfig
        self.descriptionConfig = descriptionConfig
        self.customViewConfig = customViewConfig
    }

    public init(card: MaterialCardView) {
        self.cornerRadius = card.cornerRadius
        self.backgroundColor = card.backgroundColor
        self.dividerConfig = DividerConfig(card: card)
        self.imageConfig = ImageConfig(card: card)
        self.headerConfig = HeaderConfig(card: card)
        self.descriptionConfig = DescriptionConfig(card: card)
        if let customView = card.customViewCreator { self.customViewConfig = CustomViewConfig(customView: customView, height: card.customViewHeight!, topConstraint: card.customViewTopConstraint!) }
    }

    // TODO: If they wish to update by setting something to nil, this will not work
    public func copyWithUpdates(cornerRadius: CGFloat? = nil, dividerConfig: DividerConfig? = nil, imageConfig: ImageConfig? = nil, headerConfig: HeaderConfig? = nil, descriptionConfig: DescriptionConfig? = nil, customViewConfig: CustomViewConfig? = nil) -> MaterialCardConfig {
        
        // The wonderful world of structs
        var copy = self
        
        if let cornerRadius = cornerRadius {copy.cornerRadius = cornerRadius}
        if let dividerConfig = dividerConfig {copy.dividerConfig = dividerConfig}
        if let imageConfig = imageConfig {copy.imageConfig = imageConfig}
        if let headerConfig = headerConfig {copy.headerConfig = headerConfig}
        if let descriptionConfig = descriptionConfig {copy.descriptionConfig = descriptionConfig}
        if let customViewConfig = customViewConfig {copy.customViewConfig = customViewConfig}
        
        return copy
    }

}

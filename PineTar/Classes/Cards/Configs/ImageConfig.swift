//
//  PineTar
//  ImageConfig.swift
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

public struct ImageConfig {
    var image: UIImage?
    var populateImageBlock: ((UIImageView) -> Void)?
    var imageHeight: CGFloat?
    var imageWidth: CGFloat?
    var imageAlignment: Int?
    var imageStyle: Int?
    var imageVertOffset: Int?
    var imageHorzOffset: Int?
    var imageOutlineColor: UIColor?
    var imageOutlineWidth: Int?
    
    public init(image: UIImage? = nil, populateImageBlock: ((UIImageView) -> Void)? = nil, imageHeight: CGFloat? = nil, imageWidth: CGFloat? = nil, imageAlignment: Int? = nil, imageStyle: Int? = nil, imageVertOffset: Int? = nil, imageHorzOffset: Int? = nil, imageOutlineColor: UIColor? = nil, imageOutlineWidth: Int? = nil) {
        self.image = image
        self.populateImageBlock = populateImageBlock
        self.imageHeight = imageHeight
        self.imageAlignment = imageAlignment
        self.imageStyle = imageStyle
        self.imageVertOffset = imageVertOffset
        self.imageHorzOffset = imageHorzOffset
        self.imageOutlineWidth = imageOutlineWidth
        self.imageOutlineColor = imageOutlineColor
    }
    
    public init(card: MaterialCardView) {
        self.image = card.image
        self.populateImageBlock = card.populateImageBlock
        self.imageHeight = card.imageHeight
        self.imageWidth = card.imageWidth
        self.imageAlignment = card.imageAlignment
        self.imageStyle = card.imageStyle
        self.imageVertOffset = card.imageVertOffset
        self.imageHorzOffset = card.imageHorzOffset
        self.imageOutlineWidth = card.imageOutlineWidth
        self.imageOutlineColor = card.imageOutlineColor
    }
    
    public func copyWithUpdates(image: UIImage? = nil, populateImageBlock: ((UIImageView) -> Void)? = nil, imageHeight: CGFloat? = nil, imageWidth: CGFloat? = nil, imageAlignment: Int? = nil, imageStyle: Int? = nil, imageVertOffset: Int? = nil, imageHorzOffset: Int? = nil, imageOutlineColor: UIColor? = nil, imageOutlineWidth: Int? = nil) -> ImageConfig {
        
        var copy = self
        
        if let image = image {copy.image = image}
        if let populateImageBlock = populateImageBlock {copy.populateImageBlock = populateImageBlock}
        if let imageHeight = imageHeight {copy.imageHeight = imageHeight}
        if let imageWidth = imageWidth {copy.imageWidth = imageWidth}
        if let imageAlignment = imageAlignment {copy.imageAlignment = imageAlignment}
        if let imageStyle = imageStyle {copy.imageStyle = imageStyle}
        if let imageVertOffset = imageVertOffset {copy.imageVertOffset = imageVertOffset}
        if let imageHorzOffset = imageHorzOffset {copy.imageHorzOffset = imageHorzOffset}
        if let imageOutlineWidth = imageOutlineWidth {copy.imageOutlineWidth = imageOutlineWidth}
        if let imageOutlineColor = imageOutlineColor {copy.imageOutlineColor = imageOutlineColor}
        
        return copy
    }
}

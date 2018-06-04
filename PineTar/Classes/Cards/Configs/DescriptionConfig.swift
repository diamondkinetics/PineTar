//
//  PineTar
//  DescriptionConfig.swift
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

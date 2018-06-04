//
//  PineTar
//  DividerConfig.swift
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

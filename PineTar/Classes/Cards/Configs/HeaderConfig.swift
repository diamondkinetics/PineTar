//
//  PineTar
//  HeaderConfig.swift
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

public struct HeaderConfig {
    // Header Traits
    var header: String?
    var headerColor: UIColor?
    var headerSize: CGFloat?
    var headerAlignment: Int?
    var headerVertOffset: Int?
    var headerHorzOffset: Int?
    
    // Subheader Traits
    var subheader: String?
    var subheaderColor: UIColor?
    var subheaderSize: CGFloat?
    
    public init(header: String? = nil, headerColor: UIColor? = nil, headerSize: CGFloat? = nil, headerAlignment: Int? = nil, headerVertOffset: Int? = nil, headerHorzOffset: Int? = nil,
         subheader: String? = nil, subheaderColor: UIColor? = nil, subheaderSize: CGFloat? = nil) {
        self.header = header
        self.headerColor = headerColor
        self.headerSize = headerSize
        self.headerAlignment = headerAlignment
        self.headerVertOffset = headerVertOffset
        self.headerHorzOffset = headerHorzOffset
        self.subheader = subheader
        self.subheaderColor = subheaderColor
        self.subheaderSize = subheaderSize
    }
    
    public init(card: MaterialCardView) {
        self.header = card.header
        self.headerColor = card.headerColor
        self.headerAlignment = card.headerAlignment
        self.headerSize = card.headerSize
        self.headerVertOffset = card.headerVertOffset
        self.headerHorzOffset = card.headerHorzOffset
        
        self.subheader = card.subheader
        self.subheaderColor = card.subheaderColor
        self.subheaderSize = card.subheaderSize
    }
    
    public func copyWithUpdates(header: String? = nil, headerColor: UIColor? = nil, headerSize: CGFloat? = nil, headerAlignment: Int? = nil, headerVertOffset: Int? = nil, headerHorzOffset: Int? = nil, subheader: String? = nil, subheaderColor: UIColor? = nil, subheaderSize: CGFloat? = nil) -> HeaderConfig {
        var copy = self
        
        if let header = header {copy.header = header}
        if let headerColor = headerColor {copy.headerColor = headerColor}
        if let headerSize = headerSize {copy.headerSize = headerSize}
        if let headerAlignment = headerAlignment {copy.headerAlignment = headerAlignment}
        if let headerVertOffset = headerVertOffset {copy.headerVertOffset = headerVertOffset}
        if let headerHorzOffset = headerHorzOffset {copy.headerHorzOffset = headerHorzOffset}
        if let subheader = subheader {copy.subheader = subheader}
        if let subheaderColor = subheaderColor {copy.subheaderColor = subheaderColor}
        if let subheaderSize = subheaderSize {copy.subheaderSize = subheaderSize}
        
        return copy
    }
}

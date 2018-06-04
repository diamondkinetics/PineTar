//  PineTar
//  MaterialSocialCardView.swift
//
//  Created by Tommy Martin on 5/3/18.
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

@IBDesignable
public class MaterialSocialCardView: MaterialCardView {
    override func setup() {
        configureWithDefaults()
        super.setup()
    }
    
    private func configureWithDefaults() {
        if image == nil {
            image = UIImage(named: "stock", in: Bundle(for: type(of: self)), compatibleWith: nil)
        }
        
        if divideImage == nil {
            divideImage = UIImage(named: "stock", in: Bundle(for: type(of: self)), compatibleWith: nil)
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

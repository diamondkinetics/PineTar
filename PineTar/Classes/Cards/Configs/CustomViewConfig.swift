//  PineTar
//  CustomViewConfig.swift
//
//  Created by Tommy Martin on 6/12/18
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

public struct CustomViewConfig {
    var customView: (() -> UIView)
    var height: CGFloat
    var topConstraint: CGFloat
    
    public init(customView: @escaping (() -> UIView), height: CGFloat, topConstraint: CGFloat) {
        self.customView = customView
        self.height = height
        self.topConstraint = topConstraint
    }
    
    public func copyWithUpdates(customView: @escaping (() -> UIView), height: CGFloat, topConstraint: CGFloat) -> CustomViewConfig {
        var copy = self        
        copy.customView = self.customView
        copy.height = self.height
        copy.topConstraint = self.topConstraint
        
        return copy
    }
}

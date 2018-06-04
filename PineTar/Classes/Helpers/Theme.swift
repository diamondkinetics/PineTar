//
//  PineTar
//  Theme.swift
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

// TODO: MAke all classes open for Theme overrides
// TODO: Modify themes to reflect the actual color theme
// primary, primary variant, primary variant 2, secondary, secondary variant, background, surface, error
// on primary, on secondary, on background, on surface, on error
// https://material.io/design/color/the-color-system.html#color-theme-creation

public protocol Theme {
    var primaryColor: UIColor {get}
    var highlightColor: UIColor {get}
    var textColor: UIColor {get}
    var titleColor: UIColor {get}
    var textHighlightColor: UIColor {get}
    var backgroundColor: UIColor {get}
    var font: UIFont {get}
    var buttonsAreHighlightColor: Bool {get}
}

public protocol SimpleTheme: Theme {}
extension SimpleTheme {
    var titleColor: UIColor {return highlightColor}
    var textHighlightColor: UIColor {return highlightColor}
    var buttonsAreHighlightColor: Bool {return false}
}

struct DefaultTheme: SimpleTheme {
    let primaryColor: UIColor = UIColor(red: 86.0/255.0, green: 40.0/255.0, blue: 229.0/255.0, alpha: 1.0)
    let backgroundColor: UIColor = UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0)
    let highlightColor: UIColor =  UIColor.white
    let font: UIFont = UIFont(name: "Futura", size: 20)!
    var textColor: UIColor = UIColor.black
}

public class ThemeManager {
    private static var theme: Theme = DefaultTheme()
    private init() {}
    
    public static var primaryColor: UIColor {return theme.primaryColor}
    public static var backgroundColor: UIColor {return theme.backgroundColor}
    public static var highlightColor: UIColor {return theme.highlightColor}
    public static var textColor: UIColor {return theme.textColor}
    public static var textHighlightColor: UIColor {return theme.textHighlightColor}
    public static var buttonsAreHighlightColor: Bool {return theme.buttonsAreHighlightColor}
    public static var titleColor: UIColor {return theme.titleColor}
    public static var font: UIFont {return theme.font}
    
    public static func setTheme(theme: Theme) {
        self.theme = theme
    }
}

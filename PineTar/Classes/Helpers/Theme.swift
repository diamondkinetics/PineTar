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
// TODO: Add support for color variants
// Checkout the following resource to create your material theme
// https://material.io/design/color/the-color-system.html#color-theme-creation

public protocol Theme {
    var primaryColor: UIColor {get}
    var secondaryColor: UIColor? {get}
    var backgroundColor: UIColor {get}
    var surfaceColor: UIColor {get}
    var errorColor: UIColor  {get}
    
    // Colors used for text that have readability against your set colors
    var onPrimaryColor: UIColor {get}
    var onSecondaryColor: UIColor? {get}
    var onBackgroundColor: UIColor {get}
    var onSurfaceColor: UIColor {get}
    var onErrorColor: UIColor {get}
    
    var font: UIFont {get}
}

public protocol SimpleTheme: Theme {}

// Simple themese give some defaults that allow you to only define a few colors to get started
extension SimpleTheme {
    var secondaryColor: UIColor? {return nil}
    var surfaceColor: UIColor {return UIColor.white}
    var errorColor: UIColor {return UIColor(red: 176.0/255.0, green: 0, blue: 32.0/255.0, alpha: 1.0)}
    var onSurfaceColor: UIColor {return UIColor.black}
    var onErrorColor: UIColor {return UIColor.white}
    var onSecondaryColor: UIColor? {return nil}
}

struct DefaultTheme: SimpleTheme {
    let primaryColor: UIColor = UIColor(red: 86.0/255.0, green: 40.0/255.0, blue: 229.0/255.0, alpha: 1.0)
    let backgroundColor: UIColor = UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0)
    let onPrimaryColor: UIColor = UIColor.white
    let onBackgroundColor: UIColor = UIColor.black

    let font: UIFont = UIFont(name: "Futura", size: 20)!
}

public class ThemeManager {
    private static var theme: Theme = DefaultTheme()
    private init() {}
    
    public static var primaryColor: UIColor {return theme.primaryColor}
    public static var secondaryColor: UIColor? {return theme.secondaryColor}
    public static var backgroundColor: UIColor {return theme.backgroundColor}
    public static var surfaceColor: UIColor {return theme.surfaceColor}
    public static var errorColor: UIColor {return theme.errorColor}
    
    public static var onPrimaryColor: UIColor {return theme.onPrimaryColor}
    public static var onSecondaryColor: UIColor? {return theme.onSecondaryColor}
    public static var onBackgroundColor: UIColor {return theme.onBackgroundColor}
    public static var onSurfaceColor: UIColor {return theme.onSurfaceColor}
    public static var onErrorColor: UIColor {return theme.onErrorColor}
    
    public static var font: UIFont {return theme.font}
    
    public static var useSecondaryColorForButtons: Bool = false { didSet { if secondaryColor == nil {useSecondaryColorForButtons = false } } }
    
    public static var shadowOpacity: Float = 0.5
    
    public static func setTheme(theme: Theme) {
        self.theme = theme
    }
}

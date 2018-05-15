//
//  Theme.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/3/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

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
    var textColor: UIColor = UIColor.gray
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

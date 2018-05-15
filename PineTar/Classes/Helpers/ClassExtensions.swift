//
//  ClassExtensions.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/2/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {    
    public func addCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    public func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
    }
}

public extension UIViewController {
    public func customNavController(withShadow: Bool) {
        if withShadow {
            self.navigationController?.navigationBar.addShadow()
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = ThemeManager.primaryColor
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: ThemeManager.font.withSize(22), NSAttributedStringKey.foregroundColor: ThemeManager.titleColor]
    }
    
    public func removeDefaultNavBarShadow() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

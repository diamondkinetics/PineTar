//
//  TabVCExample.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/4/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit
import PineTar

public class TabVCExample: UIViewController, MaterialTabViewDelegate {
    @IBOutlet weak var tabContainer: MaterialTabViewContainer!
    public var viewController: UIViewController {return self}
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Example"
        customNavController(withShadow: false)
        removeDefaultNavBarShadow()
        addViewControllersToTabContainer()
    }
    
    private func addViewControllersToTabContainer() {
        tabContainer.delegate = self
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.init(for: type(of: self)))
        let vc = storyboard.instantiateViewController(withIdentifier: "SocialTileExample")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "SimpleTileExample")
        let vc3 = storyboard.instantiateViewController(withIdentifier: "SocialTileExample")
        tabContainer.addViewControllers(controllers: [vc2, vc, vc3], labels: ["Item One", "Item Two", "Item Three"])
    }
}

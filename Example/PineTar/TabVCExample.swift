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

public class TabVCExample: CardAnimatorSourceVC, MaterialTabViewDelegate {
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
        let vc = storyboard.instantiateViewController(withIdentifier: "SocialTileExample") as! SocialExampleViewController
        let vc2 = storyboard.instantiateViewController(withIdentifier: "SimpleTileExample") as! CardExampleViewController
        let vc3 = storyboard.instantiateViewController(withIdentifier: "SocialTileExample") as! SocialExampleViewController
        
        vc.animatorSource = self
        vc2.animatorSource = self
        vc3.animatorSource = self
        tabContainer.addViewControllers(controllers: [vc2, vc, vc3], labels: ["Item One", "Item Two", "Item Three"])
    }
}

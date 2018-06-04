//
//  PineTar_Example
//  TabVCExample.swift
//
//  Created by Tommy Martin on 5/4/18.
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
        let vc3 = storyboard.instantiateViewController(withIdentifier: "SimpleTileExample") as! CardExampleViewController

        vc.animatorSource = self
        vc2.animatorSource = self
        vc3.animatorSource = self
        tabContainer.addViewControllers(controllers: [vc2, vc, vc3], labels: ["Item One", "Item Two", "Item Three"])
    }
}

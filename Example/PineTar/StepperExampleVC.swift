//
//  StepperExampleVC.swift
//  PineTar_Example
//
//  Created by Tommy Martin on 5/16/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import PineTar

class StepperExampleVC: UIViewController {
    
    @IBOutlet weak var stepperView: MaterialStepperView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = ThemeManager.backgroundColor
        
        let step1 = TextStep(skippable: false, text: "Full Name")
//        let step1 = ImageStep(skippable: false , text: "Profile Image")
        let step2 = ImageStep(skippable: false , text: "Profile Image")
        let step3 = TextStep(skippable: true, text: "Some More Text")
        let step4 = NumberStep(skippable: false, text: "A number is needed")
        
        stepperView.vc = self
        stepperView.steps = [step1, step2, step3, step4]
        stepperView.completion = {results in
            self.navigationController?.popViewController(animated: true)
        }
    }
}
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = ThemeManager.backgroundColor
        
        let step1 = TextStep(skippable: false, text: "Name")
        let step2 = ImageStep(skippable: false , text: "Profile Image")
        let step3 = TextStep(skippable: true, text: "Some More Text")
        
        let stepperView = MaterialStepperView(steps: [step1, step2, step3])
        self.view.addSubview(stepperView)
        stepperView.snp.makeConstraints{make in
            make.trailing.bottom.equalToSuperview().offset(-30)
            make.leading.top.equalToSuperview().offset(30)
        }
    }
}

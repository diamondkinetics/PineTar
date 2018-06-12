//
//  PineTar_Example
//  StepperExampleVC.swift
//
//  Created by Tommy Martin on 5/16/18.
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

class StepperExampleVC: UIViewController {
    
    @IBOutlet weak var stepperView: MaterialStepperView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = ThemeManager.backgroundColor
        
        let step1 = TextStep(skippable: false, text: "Full Name")
        let step2 = ImageStep(skippable: false , text: "Profile Image")
        let step3 = DateStep(skippable: true, text: "Birth Date") 
        let step4 = NumberStep(skippable: false, text: "A number is needed")
        
        stepperView.vc = self
        stepperView.steps = [step1, step2, step3, step4]
        stepperView.completion = {results in
            self.navigationController?.popViewController(animated: true)
        }
    }
}

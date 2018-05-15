//
//  MaterialStepperView.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/9/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MaterialStepperView: UIView {
    var currentStep: Int = 0
    // Super lame but with the current implementation of steps I can't make an array of Steps
    // so I just have to hide it
    private var steps: [Any]!
    
    func addStep<T: Step>(step: T) {
        // Honestly should probably just create the view in this part ... we know the type and we might as well.... then I don't have to rewrite anything
        steps.append(step)
    }
    
    private func setup() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.snp.makeConstraints{make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        for step in steps {
//            let step
//            let view = MaterialStepView.init(step: <#T##_#>)
        }
    }
}

private class MaterialStepView<T: Step>: UIView {
    private var step: T
    var progressView: UIView!
    
    init(step: T) {
        self.step = step
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        var appendStr = ""
        var resultView: UIView?
        
        if let value = step.value {
            resultView = step.createResultView(value: value)
            // progressView is check
            appendStr = ":"
        } else {
            //Progress bar is number
        }
        
        progressView = UIView()
        progressView.backgroundColor = ThemeManager.highlightColor
        progressView.addCornerRadius(radius: 13)
        
        addSubview(progressView)
        progressView.snp.makeConstraints{make in
            make.height.width.equalTo(26)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        let label = UILabel()
        label.font = ThemeManager.font.withSize(20)
        label.textColor = ThemeManager.textColor
        label.text = step.text.appending(appendStr)
        addSubview(label)
        
        label.snp.makeConstraints{make in
            make.leading.equalTo(progressView.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
        }
        
        guard let result = resultView else {return}
        addSubview(result)
        result.snp.makeConstraints{make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(label.snp.trailing).offset(5)
        }
    }
}

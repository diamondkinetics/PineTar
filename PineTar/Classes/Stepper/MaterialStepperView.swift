//
//  MaterialStepperView.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/9/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

public class MaterialStepperView: UIView {
    public var incompleteColor: UIColor = UIColor.gray
    private var steps: [Step]
    private var stepperViews: [MaterialStepView] = []
    
    public init(steps: [Step]) {
        self.steps = steps
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        for step in steps {
            let view = MaterialStepView(step: step, index: stepperViews.count + 1, incompleteColor: incompleteColor)
            addSubview(view)
            view.snp.makeConstraints{make in
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(50)
                
                if let last = stepperViews.last {
                    make.top.equalTo(last.snp.bottom)
                } else {
                    make.top.equalToSuperview()
                }
            }
            
            stepperViews.append(view)
        }
        
        for i in 1..<stepperViews.count {
            let view = UIView()
            
            let progressView1 = stepperViews[i - 1].progressViewContainer!
            let progressView2 = stepperViews[i].progressViewContainer!
            
            let fillColor = ThemeManager.buttonsAreHighlightColor ? ThemeManager.highlightColor : ThemeManager.primaryColor
            if stepperViews[i].step.state == .incomplete {
                view.backgroundColor = incompleteColor
            } else {
                view.backgroundColor = fillColor
            }
            
            self.addSubview(view)

            view.snp.makeConstraints{make in
                make.centerX.equalTo(progressView1.snp.centerX)
                make.top.equalTo(progressView1.snp.bottom).offset(4)
                make.bottom.equalTo(progressView2.snp.top).offset(-4)
                make.width.equalTo(2)
            }
        }
        
        moveForwardStep()
    }
    
    private func indexOfCurrentStep() -> Int? {
        for i in 0..<steps.count {
            let step = steps[i]
            if step.state == .current { return  i }
        }
        
        return nil
    }
    
    private func moveForwardStep() {
        guard let currIndex = indexOfCurrentStep() else {
            steps.first?.state = .current
            stepperViews.first?.update()
            return
        }
        
        steps[currIndex].state = .complete
        stepperViews[currIndex].update()
        
        if currIndex < steps.count - 1 {
            steps[currIndex - 1].state = .current
            stepperViews[currIndex - 1].update()
        }
    }
}

private class MaterialStepView: UIView {
    var step: Step
    private var index: Int
    private var progressView: UIView!
    private var label: UILabel!
    var progressViewContainer: UIView!
    var incompleteColor: UIColor
    
    init(step: Step, index: Int, incompleteColor: UIColor) {
        self.step = step
        self.index = index
        self.incompleteColor = incompleteColor
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let resultView: UIView? = step.createResultView()
        createProgressViewContainer()
        updateProgressView()
        
        createLabel()
        updateLabel()
        
        guard let result = resultView else {return}
        addSubview(result)
        result.snp.makeConstraints{make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(label.snp.trailing).offset(5)
        }
    }
    
    private func createLabel() {
        label = UILabel()
        label.font = ThemeManager.font.withSize(20)
        addSubview(label)
        
        label.snp.makeConstraints{make in
            make.leading.equalTo(progressViewContainer.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
        }
    }
    
    private func updateLabel() {
        var appendStr = ""
        let resultView: UIView? = step.createResultView()
        if resultView != nil {appendStr = ":"}
        
        label.textColor = step.state == .incomplete ? incompleteColor : ThemeManager.textColor
        label.text = step.text.appending(appendStr)
    }

    private func createProgressViewContainer() {
        progressViewContainer = UIView()
        progressViewContainer.addCornerRadius(radius: 13)
        addSubview(progressViewContainer)
        progressViewContainer.snp.makeConstraints{make in
            make.height.width.equalTo(26)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func updateProgressView() {
        if progressView != nil {progressView.removeFromSuperview()}
        
        if step.state == .complete {
            let image = UIImage.init(named: "check", in: Bundle(for: type(of: self)), compatibleWith: nil)
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            progressView = imageView

            imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = ThemeManager.textHighlightColor
        } else {
            let numLabel = UILabel()
            numLabel.textColor = ThemeManager.textHighlightColor
            numLabel.font = ThemeManager.font.withSize(14)
            numLabel.textAlignment = .center
            numLabel.text = "\(index)"
            progressView = numLabel
        }
        
        let fillColor = ThemeManager.buttonsAreHighlightColor ? ThemeManager.highlightColor : ThemeManager.primaryColor
        progressViewContainer.backgroundColor = step.state == .incomplete ? incompleteColor : fillColor
        
        progressViewContainer.addSubview(progressView)
        progressView.snp.makeConstraints {make in
            make.top.leading.equalToSuperview().offset(3)
            make.bottom.trailing.equalToSuperview().offset(-3)
        }
    }
    
    func update() {
        updateProgressView()
        updateLabel()
    }
}

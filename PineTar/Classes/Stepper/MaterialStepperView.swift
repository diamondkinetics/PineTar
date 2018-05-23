//
//  MaterialStepperView.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/9/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class MaterialStepperView: UIView, EnableStepDelegate {
    public var incompleteColor: UIColor = UIColor.gray
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var progressColorView: UIView!
    private var currIndex: Int!
    public var vc: UIViewController!
    public var completion: ((Array<Any>) -> (Void))?
    private var buttons: [UIButton]!
    
    public var steps: [Step]! {
        didSet {
            setup()
        }
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        steps = [Step(skippable: false, text: "Example Step")]
        setup()
    }

    private func setup() {
        let progressView = UIView()
        progressView.backgroundColor = UIColor.white
        progressView.addShadow()
        
        currIndex = 0
        
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        
        scrollView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints{make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        
        contentView = UIView()
        contentView.backgroundColor = ThemeManager.backgroundColor
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints{make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(self.snp.height).offset(-50)
            make.width.equalTo(self.snp.width).multipliedBy(steps.count)
        }
        
        self.addSubview(progressView)
        progressView.snp.makeConstraints{make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        let progressBar = UIView()
        progressView.addSubview(progressBar)
        progressBar.addCornerRadius(radius: 8)
        progressBar.backgroundColor = ThemeManager.backgroundColor
        progressBar.snp.makeConstraints{make in
            make.height.equalTo(16)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        progressColorView = UIView()
        progressColorView.backgroundColor = ThemeManager.primaryColor
        progressBar.addSubview(progressColorView)
        progressColorView.snp.makeConstraints{make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(0)
        }
        
        let leading = 25
        var previousCard: MaterialCardView?
        buttons = []
        
        for step in steps {
            let card = MaterialCardView(frame: CGRect.zero)
            card.layer.cornerRadius = 4
            card.pressAnimationEnabled = false
            card.backgroundColor = UIColor.white
            contentView.addSubview(card)
            
            card.snp.makeConstraints{make in
                make.top.equalToSuperview().offset(25)
                make.width.equalTo(self.snp.width).offset(-2 * leading)
                make.height.equalTo(card.snp.width).dividedBy(1.3)

                if let previousCard = previousCard {
                    make.leading.equalTo(previousCard.snp.trailing).offset(2 * leading)
                } else {
                    make.leading.equalToSuperview().offset(leading)
                }
            }
            
            let label = UILabel()
            label.text = step.text
            label.font = ThemeManager.font.withSize(18)
            label.textColor = ThemeManager.textColor
            card.addSubview(label)
            
            label.snp.makeConstraints{make in
                make.leading.equalTo(30)
                make.top.equalTo(10)
                make.height.equalTo(40)
            }
            
            let continueButton = MaterialButton(frame: CGRect.zero)
            let buttonText = step == steps.last ? "Complete" : "Continue"
            continueButton.setTitle(buttonText, for: .normal)
            card.addSubview(continueButton)
            continueButton.addTarget(self, action: #selector(moveForward(button:)), for: .touchUpInside)
            continueButton.snp.makeConstraints{make in
                make.width.equalTo(125)
                make.height.equalTo(40)
                make.bottom.trailing.equalTo(-10)
            }
            
            buttons.append(continueButton)
            step.delegate = self

            let view = step.createView(vc: self.vc)
            card.addSubview(view)
            view.snp.makeConstraints{make in
                make.top.equalTo(label.snp.bottom).offset(15)
                make.bottom.equalTo(continueButton.snp.top).offset(-15)
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().offset(-15)
            }
            
            steps.first?.select()
            
            guard previousCard != nil else {
                previousCard = card
                continue
            }
            
            // TODO: MAke a plain jane material button
            let backButton = UIButton()
            backButton.setTitleColor(UIColor(red: 228.0/255, green: 36.0/255, blue: 36.0/255, alpha: 1.0), for: .normal)
            backButton.titleLabel?.font = ThemeManager.font.withSize(16)
            backButton.setTitle("Back", for: .normal)
            backButton.addTarget(self, action: #selector(moveBackward), for: .touchUpInside)
            card.addSubview(backButton)
            backButton.snp.makeConstraints{make in
                make.width.equalTo(70)
                make.height.equalTo(40)
                make.trailing.equalTo(continueButton.snp.leading).offset(-5)
                make.bottom.equalTo(-10)
            }
            
            previousCard = card
        }
    }
    
    @objc private func moveForward(button: UIButton) {
        if button.titleLabel?.text == "Complete" {
            progressColorView.snp.removeConstraints()
            
            progressColorView.snp.makeConstraints{make in
                make.leading.top.bottom.trailing.equalToSuperview()
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            }, completion: {completed in
                self.completion?([])
            })
        } else {
            let scrollToRect = CGRect.init(x: scrollView.contentOffset.x + self.frame.width, y: 0, width: self.frame.width, height: scrollView.frame.height)
            scrollView.scrollRectToVisible(scrollToRect, animated: true)
        }
    }
    
    @objc private func moveBackward() {
        let scrollToRect = CGRect.init(x: scrollView.contentOffset.x - self.frame.width, y: 0, width: self.frame.width, height: scrollView.frame.height)
        scrollView.scrollRectToVisible(scrollToRect, animated: true)
    }
    
    public func enableStep(step: Step) {
        let stepIndex = steps.index(of: step)!
        let button = buttons[stepIndex]
        button.alpha = 1.0
        button.isEnabled = true
    }
    
    public func disableStep(step: Step) {
        let stepIndex = steps.index(of: step)!
        let button = buttons[stepIndex]
        button.alpha = 0.5
        button.isEnabled = false
    }
}

extension MaterialStepperView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percentage = scrollView.contentOffset.x / contentView.frame.width
        progressColorView.snp.removeConstraints()
        
        progressColorView.snp.makeConstraints{make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(percentage)
        }
        
        self.layoutIfNeeded()
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / self.frame.width)
        if index != currIndex {
            steps[currIndex].deselect()
            steps[index].select()
        }
        
        currIndex = index
    }
}

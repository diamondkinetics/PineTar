//
//  MaterialTabView.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/2/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public protocol TabDelegate {
    func tabPressed(atIndex index: Int)
}

@IBDesignable
public class MaterialTabView: UIView  {
    private var stackView: UIStackView!
    private var selectedView: UIView?
    private var selectedIndex: Int = 0
    var tabDelegate: TabDelegate!
    
    var options: [String]? {
        didSet {
            setOptions()
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUp()
        self.options = ["Item One", "Item Two"]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    
    func setUp() {
        self.backgroundColor = ThemeManager.primaryColor
        createStackView()
        self.addShadow()
    }
    
    private func createStackView() {
        self.stackView = UIStackView()
        self.stackView.distribution = .fillEqually
        self.addSubview(stackView)
        self.stackView.snp.makeConstraints {(make) -> Void in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    private func createSelectedView() {
        selectedView?.removeFromSuperview()
        let view = UIView()
        view.backgroundColor = ThemeManager.highlightColor
        self.addSubview(view)
        self.selectedView = view
        selectedViewMakeConstraints(withOffset: 0)
    }
    
    private func selectedViewMakeConstraints(withOffset offset: CGFloat) {
        self.selectedView?.snp.removeConstraints()
        self.selectedView?.snp.makeConstraints {(make) -> Void in
            make.bottom.equalToSuperview()
            make.height.equalTo(4)
            make.leading.equalToSuperview().offset(offset)
            make.width.equalTo(100)
            make.width.equalToSuperview().dividedBy(options!.count)
        }
    }
    
    private func setOptions() {
        for view in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(view)
        }
        
        for i in 0..<options!.count {
            let option = options![i]
            let tab = UIButton(type: UIButtonType.system)
            tab.addTarget(self, action: #selector(didPressOption(sender:)), for: UIControlEvents.touchUpInside)
            let color = i == selectedIndex ? ThemeManager.textHighlightColor : UIColor.lightGray
            tab.setTitleColor(color, for: .normal)
            tab.titleLabel?.font =  ThemeManager.font.withSize(16)
            tab.setTitle(option, for: .normal)
            tab.tag = i
            stackView.addArrangedSubview(tab)
        }
        
        createSelectedView()
    }
    
    func setOffset(percentage: CGFloat) {
        let offset = percentage * self.bounds.width
        selectedViewMakeConstraints(withOffset: offset)
    }
    
    func select(atIndex index: Int) {
        let tabs = self.stackView.arrangedSubviews
        
        for i in 0..<tabs.count {
            let tab = tabs[i] as! UIButton
            let color = i == index ? ThemeManager.textHighlightColor : UIColor.lightGray
            tab.setTitleColor(color, for: .normal)
        }
        
        self.selectedIndex = index
    }
    
    @objc func didPressOption(sender: UIButton) {
        let index = sender.tag
        tabDelegate.tabPressed(atIndex: index)
    }
}


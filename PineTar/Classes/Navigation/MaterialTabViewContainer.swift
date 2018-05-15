//
//  MaterialTabViewContainer.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/4/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

public class MaterialTabViewController: UIViewController {
    func addViewController(vc: UIViewController) {
        addChildViewController(vc)
    }
}

public protocol MaterialTabViewDelegate {
    var viewController: UIViewController {get}
}

extension MaterialTabViewDelegate {
    func addViewController(vc: UIViewController) {
        viewController.addChildViewController(vc)
    }
}

@IBDesignable
public class MaterialTabViewContainer: UIView {
    private var tabView: MaterialTabView!
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var viewControllers: [UIViewController] = []
    public var delegate: MaterialTabViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init(delegate: MaterialTabViewDelegate) {
        self.delegate = delegate
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        
        tabView.options = ["Item One", "Item Two", "Item Three"]
    }
    
    private func setup() {
        backgroundColor = ThemeManager.backgroundColor
        tabView = MaterialTabView(frame: CGRect.zero)
        tabView.tabDelegate = self
        scrollView = UIScrollView(frame: CGRect.zero)
        addSubview(scrollView)
        addSubview(tabView)
        tabView.snp.makeConstraints {(make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints {(make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(tabView.snp.bottom)
        }
        
        contentView = UIView(frame: CGRect.zero)
        scrollView.addSubview(contentView)
        createContentViewConstraints()
    }
    
    private func createContentViewConstraints() {
        contentView.snp.removeConstraints()
        contentView.snp.makeConstraints{(make) in
            make.leading.trailing.bottom.top.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(viewControllers.count)
            make.height.equalTo(self.snp.height).offset(-30)
        }
    }
    
    public func addViewControllers(controllers: [UIViewController], labels: [String]) {
        for vc in controllers {
            addVC(vc: vc)
        }
        
        tabView.options = labels
    }
    
    private func addVC(vc: UIViewController) {
        if delegate == nil {
            fatalError("You must add a delegate before you can add view controllers")
        }

        delegate.addViewController(vc: vc)
        contentView.addSubview(vc.view)

        vc.view.snp.makeConstraints{(make) in
            if self.viewControllers.count == 0 {
                make.leading.equalToSuperview()
            } else {
                make.leading.equalTo(viewControllers.last!.view.snp.trailing)
            }

            make.width.equalTo(self.snp.width)
            make.top.bottom.equalToSuperview()
        }

        viewControllers.append(vc)
        vc.didMove(toParentViewController: delegate.viewController)
        createContentViewConstraints()
    }
}

extension MaterialTabViewContainer: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percentage = scrollView.contentOffset.x/scrollView.contentSize.width
        tabView.setOffset(percentage: percentage)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index =  Int((scrollView.contentOffset.x + 5)/self.frame.width)
        tabView.select(atIndex: index)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index =  Int((scrollView.contentOffset.x + 5)/self.frame.width)
        tabView.select(atIndex: index)
    }
}

extension MaterialTabViewContainer: TabDelegate {
    public func tabPressed(atIndex index: Int) {
        let rect = CGRect(origin: CGPoint(x: CGFloat(index) * self.frame.width, y: 0), size: self.frame.size)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
}

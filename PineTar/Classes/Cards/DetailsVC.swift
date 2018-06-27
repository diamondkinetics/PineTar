//
//  PineTar
//  DetailsVC.swift
//
//  Created by Tommy Martin on 5/7/18.
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

public class DetailsVC: UIViewController {
    private var sendingCard: MaterialCardView
    public var cardConfig: MaterialCardConfig
    
    private var contentView: UIView
    private var source: CardAnimatorSourceVC!
    private var offset: Int?
    private var bottomFloatView: UIView?
    
    public var statusBarHidden = false {
        didSet {
            UIView.animate(withDuration: 0.5, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            }, completion: {complete in
                self.source.statusBarHidden = true
            })
        }
    }
    
    public var useCurrentOffset: Bool = false {
        didSet {
            if useCurrentOffset {
                self.offset = Int(sendingCard.ogFrame!.minX)
            } else {
                self.offset = nil
            }
        }
    }
    
    public init(sendingCard: MaterialCardView, cardConfig: MaterialCardConfig, contentView: UIView, bottomFloatView: UIView? = nil) {
        self.sendingCard = sendingCard
        self.cardConfig = cardConfig
        self.contentView = contentView
        self.bottomFloatView = bottomFloatView
        
        super.init(nibName: nil, bundle: Bundle.init(for: type(of: self)))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        transitioningDelegate = self
        setup()
    }
    
    private func setup() {
        view.backgroundColor = ThemeManager.backgroundColor
        
        if contentView is UITableView {
            setupWithTableView()
        } else {
            setupClassic()
        }
        
        createBackButton()
        addFloatView()
    }
    
    private func setupClassic() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = ThemeManager.backgroundColor
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(self.bottomFloatView?.frame.height ?? 0))
        }
        
        let scrollContentView = UIView()
        let height = contentView.frame.height
        
        scrollContentView.backgroundColor = sendingCard.backgroundColor
        scrollView.addSubview(scrollContentView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        scrollContentView.snp.makeConstraints{make in
            make.leading.trailing.bottom.top.equalToSuperview()
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo((sendingCard.ogHeight ?? sendingCard.frame.height) + height)
        }
        
        let card = MaterialCardView(frame: CGRect.zero)
        card.tag = sendingCard.tag
        card.pressAnimationEnabled = false
        card.update(forConfig: cardConfig)
        if let offset = offset {
            card.squeeze(byOffset: offset)
            card.updateConstraintsForSqueeze()
        }
        card.layer.shadowColor = UIColor.clear.cgColor
        scrollContentView.addSubview(card)
        
        card.snp.makeConstraints{make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.sendingCard.ogHeight ?? self.sendingCard.frame.height)
        }
        
        scrollContentView.addSubview(contentView)
        contentView.snp.makeConstraints{make in
            make.top.equalTo(card.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(height)
            make.width.equalToSuperview()
        }
    }
    
    private func setupWithTableView() {
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.snp.makeConstraints{make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        let card = MaterialCardView(frame: CGRect.zero)
        card.pressAnimationEnabled = false
        card.tag = sendingCard.tag
        card.update(forConfig: cardConfig)
        
        if let offset = offset {
            card.squeeze(byOffset: offset)
            card.updateConstraintsForSqueeze()
        }
        
        //TODO: Make bottom corners rounded
        containerView.addSubview(card)
        
        card.snp.makeConstraints{make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.sendingCard.ogHeight ?? self.sendingCard.frame.height)
        }
        
        let tableView = contentView as! UITableView
        containerView.addSubview(tableView)
        tableView.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(card.snp.bottom)
            //            make.top.equalToSuperview().offset(self.sendingCard.ogHeight ?? self.sendingCard.frame.height)
            make.bottom.equalToSuperview().offset(-(self.bottomFloatView?.frame.height ?? 0))
        }
        
        containerView.bringSubview(toFront: card)
    }
    
    private func addFloatView() {
        guard let floatView = self.bottomFloatView else {return}
        
        let floatViewHeight = floatView.frame.height
        self.view.addSubview(floatView)
        
        floatView.snp.makeConstraints{make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.height.equalTo(floatViewHeight)
        }
    }
    
    private func createBackButton() {
        let backButton = UIButton()
        backButton.backgroundColor = UIColor.darkGray.withAlphaComponent(0.65)
        backButton.layer.cornerRadius = 20
        
        let image = UIImage.init(named: "xIcon", in: Bundle(for: type(of: self)), compatibleWith: nil)
        backButton.setImage(image, for: UIControlState.normal)
        backButton.addTarget(self, action: #selector(backButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(backButton)
        backButton.snp.makeConstraints{make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        UIView.animate(withDuration: 0.3, animations: {
            sender.alpha = 0
        })
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    public override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
}

extension DetailsVC: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let source = source as? CardAnimatorSourceVC {
            self.source = source
            return CardAnimatorFrom(from: self.sendingCard, offset: self.offset)
        } else if let source = source as? DetailPresentingVC {
            self.source = source.animatorSource
            return CardAnimatorFrom(from: self.sendingCard, offset: self.offset )
        }
        
        return nil
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardAnimatorTo(with: sendingCard, source: source, offset: self.offset)
    }
}

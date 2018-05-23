//
//  DetailsVC.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/7/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

public class DetailsVC: UIViewController {
    private var sendingCard: MaterialCardView
    public var cardConfig: MaterialCardConfig
    private var contentView: UIView
    private var source: CardAnimatorSourceVC!
    public var statusBarHidden = false {
        didSet {
            UIView.animate(withDuration: 0.5, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            }, completion: {complete in
                self.source.statusBarHidden = true
            })
        }
    }
    
    public init(sendingCard: MaterialCardView, cardConfig: MaterialCardConfig, contentView: UIView) {
        self.sendingCard = sendingCard
        self.cardConfig = cardConfig
        self.contentView = contentView
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
    }
    
    private func setupClassic() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = ThemeManager.backgroundColor
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{make in
            make.bottom.top.leading.trailing.equalToSuperview()
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
            make.height.equalTo(sendingCard.frame.height + height) // TODO: This will have to be calculated
        }
        
        let card = MaterialCardView(frame: CGRect.zero)
        card.pressAnimationEnabled = false
        card.update(forConfig: cardConfig)
        card.layer.shadowColor = UIColor.clear.cgColor
        scrollContentView.addSubview(card)
        
        card.snp.makeConstraints{make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.sendingCard.frame.height)
        }
        
        scrollContentView.addSubview(contentView)
        contentView.snp.makeConstraints{make in
            make.top.equalTo(card.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(height)
            make.width.equalToSuperview()
        }
        
        createBackButton()
    }
    
    private func setupWithTableView() {
        let card = MaterialCardView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.sendingCard.frame.height))
        card.pressAnimationEnabled = false
        card.update(forConfig: cardConfig)
        card.layer.shadowColor = UIColor.clear.cgColor
        
        let tableView = contentView as! UITableView
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        tableView.tableHeaderView = card
        createBackButton()
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
        
        if let source = source as? CardAnimatorSourceVC, let card = source.sendingCard {
            self.source = source
            self.sendingCard = card
            return CardAnimatorFrom(from: card)
        } else if let source = source as? StatusBarHandler, let card = source.sendingCard {
            self.source = source.animatorSource
            self.sendingCard = card
            return CardAnimatorFrom(from: card)
        }
        
        return nil
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardAnimatorTo(with: sendingCard, source: source)
    }
}

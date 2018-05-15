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
    private var sendingCard: MaterialCardView!
    public var cardConfig: MaterialCardConfig!
    
    override public func viewDidLoad() {
        transitioningDelegate = self
        setup()
    }
    
    private func setup() {
        guard cardConfig != nil else {
            fatalError("DetailVC must be given a cardConfig")
        }
        
        view.backgroundColor = ThemeManager.backgroundColor
        let card = MaterialCardView(frame: CGRect.zero)
        card.update(forConfig: cardConfig)
        self.view.addSubview(card)
        
        card.snp.makeConstraints{make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        let backButton = UIButton()
        backButton.backgroundColor = UIColor.darkGray.withAlphaComponent(0.65)
        backButton.layer.cornerRadius = 20
        
        let image = UIImage.init(named: "xIcon", in: Bundle(for: type(of: self)), compatibleWith: nil)
        backButton.setImage(image, for: UIControlState.normal)
        backButton.addTarget(self, action: #selector(backButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(backButton)
        backButton.snp.makeConstraints{make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        UIView.animate(withDuration: 0.3, animations: {
            sender.alpha = 0
        })
    }
}

extension DetailsVC: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let source = source as? CardAnimatorSource, let card = source.sendingCard {
            self.sendingCard = card
            return CardAnimatorFrom(from: card)
        }
        
        return nil
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardAnimatorTo(with: sendingCard)
    }
}

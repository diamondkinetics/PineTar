//
//  CardTransitioningDelegate.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/7/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public protocol CardAnimatorSource {
    var sendingCard: MaterialCardView? {get}
}

class CardAnimatorFrom: NSObject, UIViewControllerAnimatedTransitioning {
    // TODO : Create a bounce effect
    fileprivate var velocity = 0.5
    var card: MaterialCardView
    
    init(from card: MaterialCardView) {
        self.card = card
        super.init()
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let to = transitionContext.viewController(forKey: .to)!
        let from = transitionContext.viewController(forKey: .from)!
        container.addSubview(to.view)
        container.addSubview(from.view)
        
        // Animation Context Setup
        let cardLoc = CGPoint(x: card.bounds.minX, y: card.bounds.minY)
        let cardSuperview = card.superview
        
        let largerLoc = card.convert(cardLoc, to: from.view)
        card.removeFromSuperview()
        
        let top = card.frame.minY
        let bottom = cardSuperview!.frame.height - card.frame.maxY
        let leading = card.frame.minX
        let trailing = cardSuperview!.frame.width - card.frame.maxX
        
        card.frame.origin = largerLoc
        from.view.addSubview(card)
        
        self.card.snp.removeConstraints()
        self.card.snp.makeConstraints { make in
            make.top.equalTo(to.view.snp.top)
            make.left.equalTo(to.view.snp.left)
            make.right.equalTo(to.view.snp.right)
            make.bottom.equalTo(to.view.snp.bottom)
        }
        
        UIView.animate(withDuration: velocity, animations: {
            container.layoutIfNeeded()
        }, completion: {_ in
            transitionContext.completeTransition(true)
            self.card.removeFromSuperview()
            cardSuperview?.addSubview(self.card)
            self.card.snp.removeConstraints()
            
            self.card.snp.makeConstraints{ make in
                make.top.equalTo(cardSuperview!.snp.top).offset(top)
                make.bottom.equalTo(cardSuperview!.snp.bottom).offset(-bottom)
                make.leading.equalTo(cardSuperview!.snp.leading).offset(leading)
                make.trailing.equalTo(cardSuperview!.snp.trailing).offset(-trailing)
            }
        })
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return velocity
    }
    
}

class CardAnimatorTo: NSObject, UIViewControllerAnimatedTransitioning {
    fileprivate var velocity = 0.5
    var card: MaterialCardView
    
    init(with card: MaterialCardView) {
        self.card = card
        super.init()
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let to = transitionContext.viewController(forKey: .to)!
        let from = transitionContext.viewController(forKey: .from)!
        container.addSubview(to.view)
        container.addSubview(from.view)
        
        let movingCard = from.view.subviews.filter{$0 is MaterialCardView}[0] as! MaterialCardView
        movingCard.removeFromSuperview()
        from.view.backgroundColor = UIColor.clear
        movingCard.setCornerRadius(radius: card.cornerRadius)
        movingCard.frame.origin = CGPoint.init(x: 0, y: 0)
        from.view.addSubview(movingCard)
        
        movingCard.snp.removeConstraints()
        movingCard.snp.makeConstraints{make in
            make.trailing.equalTo(card.snp.trailing)
            make.top.equalTo(card.snp.top)
            make.leading.equalTo(card.snp.leading)
            make.bottom.equalTo(card.snp.bottom)
        }
        
        
        UIView.animate(withDuration: velocity, animations: {
            container.layoutIfNeeded()

        }, completion: {_ in
            movingCard.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return velocity
    }
    
}

//
//  PineTar
//  CardTransitioningDelegate.swift
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

class CardAnimatorFrom: NSObject, UIViewControllerAnimatedTransitioning {
    // TODO : Create a bounce effect
    fileprivate var velocity = 0.5
    var card: MaterialCardView
    private var offset: Int?
    
    init(from card: MaterialCardView, offset: Int?) {
        self.card = card
        self.offset = offset
        super.init()
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let to = transitionContext.viewController(forKey: .to)!
        let from = transitionContext.viewController(forKey: .from)!
        container.addSubview(to.view)
        container.addSubview(from.view)
        
        
        if let to = to as? DetailsVC {
            to.statusBarHidden = true
        }
        
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
        
        if let offset = offset {
            card.squeeze(byOffset: offset)
            card.updateConstraintsForSqueeze()
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
            
            if let offset = self.offset {
                self.card.squeeze(byOffset: -offset)
                self.card.updateConstraintsForSqueeze()
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
    var source: CardAnimatorSourceVC
    private var offset: Int?
    
    init(with card: MaterialCardView, source: CardAnimatorSourceVC, offset: Int?) {
        self.card = card
        self.source = source
        self.offset = offset
        super.init()
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let to = transitionContext.viewController(forKey: .to)!
        let from = transitionContext.viewController(forKey: .from)!
        
        container.addSubview(to.view)
        container.addSubview(from.view)
        
        source.statusBarHidden = false
        let scrollViews = (from.view.subviews.filter{$0 is UIScrollView})
        
        var movingCard: UIView
        
        if scrollViews.count == 0 {
            movingCard = from.view.subviews[0]
            
            for i in 1..<from.view.subviews.count {
                let view = from.view.subviews[i]
                UIView.animate(withDuration: 0.2, animations: { view.alpha = 0 })
            }
        } else {
            let scrollView = scrollViews[0] as! UIScrollView
            movingCard = scrollView.subviews[0]
            scrollView.alpha = 0.0
            
            let otherViews = from.view.subviews.filter{!($0 is UIScrollView)}
            for view in otherViews {
                UIView.animate(withDuration: 0.2, animations: { view.alpha = 0 })
            }
        }
        
        movingCard.layer.masksToBounds = true
        
        movingCard.removeFromSuperview()
        from.view.backgroundColor = UIColor.clear
        
        //movingCard.setCornerRadius(radius: card.cornerRadius) // TODO: Re-add
        movingCard.frame.origin = CGPoint.init(x: 0, y: 0)
        from.view.addSubview(movingCard)
        
        movingCard.snp.removeConstraints()
        movingCard.snp.makeConstraints{make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        container.layoutIfNeeded()
        
        movingCard.snp.removeConstraints()
        movingCard.snp.makeConstraints{make in
            make.trailing.equalTo(card.snp.trailing)
            make.top.equalTo(card.snp.top)
            make.leading.equalTo(card.snp.leading)
            make.bottom.equalTo(card.snp.bottom)
        }
        
        if let offset = offset {
            let card = movingCard.subviews.filter{$0 is MaterialCardView}.first as? MaterialCardView
            card?.squeeze(byOffset: -offset)
            card?.updateConstraintsForSqueeze()
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

//
//  CardSourceAnimatorVC.swift
//  PineTar
//
//  Created by Tommy Martin on 5/15/18.
//

import Foundation

open class CardAnimatorSourceVC: UIViewController {
    public var sendingCard: MaterialCardView?
    
    public var statusBarHidden = false {
        didSet {
            UIView.animate(withDuration: 0.5, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            })
        }
    }
    
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    open override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
}

public protocol StatusBarHandler {
    var animatorSource: CardAnimatorSourceVC! {get}
    var sendingCard: MaterialCardView? {get}
}

extension StatusBarHandler {
    func setStatusBarHidden(isHidden: Bool) {
        animatorSource.statusBarHidden = isHidden
    }
}

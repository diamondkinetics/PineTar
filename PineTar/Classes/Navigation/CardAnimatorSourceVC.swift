//
//  PineTar
//  CardSourceAnimatorVC.swift
//
//  Created by Tommy Martin on 5/15/18.
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

public protocol DetailPresentingVC: class {
    var animatorSource: CardAnimatorSourceVC? {get set}
}

extension DetailPresentingVC where Self: UIViewController {
    func setStatusBarHidden(isHidden: Bool) {
        animatorSource?.statusBarHidden = isHidden
    }
    
    public func presentDetailVC(fromCard card: MaterialCardView, withContentView contentView: UIView, bottomFloatingView: UIView? = nil, useCurrentOffset: Bool = false) -> DetailsVC {
        let config = MaterialCardConfig(card: card)
        let vc = DetailsVC(sendingCard: card, cardConfig: config, contentView: contentView, bottomFloatView: bottomFloatingView)
        vc.useCurrentOffset = useCurrentOffset
        self.present(vc, animated: true, completion: nil)
        
        return vc
    }
}

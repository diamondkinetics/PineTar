//
//  Step.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/9/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

enum State {
    case incomplete
    case complete
    case current
}


public class Step {
    var skippable: Bool
    var text: String
    public var value: Any?
    var resultView: UIView?
    var state: State = .incomplete {
        didSet {if self.state == .current { select() }}
    }
    
    // Need action
    public init(skippable: Bool, text: String) {
        self.skippable = skippable
        self.text = text
    }
    
    func createResultView() -> UIView? {
        guard value != nil else {return nil}
        return UIView()
    }
    
    func select() {}
}

public class ImageStep: Step {
    override func createResultView() -> UIView? {
        resultView?.removeFromSuperview()
        guard let value = value as? UIImage else {return nil}
        let view = UIImageView.init(image: value)
        view.contentMode = .scaleAspectFit
        self.resultView = view
        return view
    }
}

public class TextStep: Step {
    override func createResultView() -> UIView? {
        resultView?.removeFromSuperview()
        if value == nil {value = ""}
        
        let label = UITextField()
        label.text = value as? String
        label.textColor = ThemeManager.textColor
        label.font = ThemeManager.font.withSize(18)
        self.resultView = label
        
        return label
    }
    
    override func select() {
        guard let resultView = resultView as? UITextField else {
            _ = createResultView()
            (self.resultView as! UITextField).becomeFirstResponder()
            return
        }
        
        resultView.becomeFirstResponder()
    }
}

// TODO: Split out steps
//protocol Step {
//    var skippable: Bool {get}
//    var text: String {get}
//    var value: ValueType? {get}
//    associatedtype ValueType
//
//    func createResultView(value: ValueType) -> UIView
//}
//
//struct ImageStep: Step {
//    var skippable: Bool
//    var text: String
//    var value: UIImage?
//
//    func createResultView(value: ValueType) -> UIView {
//        let imageView = UIImageView()
//        imageView.image = value
//
//        return imageView
//    }
//
//}
//
//struct DateStep: Step {
//    var skippable: Bool
//    var text: String
//    var value: Date?
//
//    func createResultView(value: ValueType) -> UIView {
//        let label = UILabel()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM dd, yyyy"
//        label.text = dateFormatter.string(from: value)
//        label.textColor = ThemeManager.textColor
//        label.font = ThemeManager.font.withSize(20)
//
//        return label
//    }
//}
//
//struct TextStep: Step {
//    var skippable: Bool
//    var text: String
//    var value: String?
//
//    func createResultView(value: ValueType) -> UIView {
//        let label = UILabel()
//        label.text = value
//        label.textColor = ThemeManager.textColor
//        label.font = ThemeManager.font.withSize(20)
//
//        return label
//    }
//}
//
//struct CustomStep: Step {
//    var skippable: Bool
//    var text: String
//    var value: Any?
//    var viewForValue: ((Any) -> UIView)
//
//    func createResultView(value: ValueType) -> UIView {
//        return viewForValue(value)
//    }
//}

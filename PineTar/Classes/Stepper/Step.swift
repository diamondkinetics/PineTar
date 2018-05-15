//
//  Step.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/9/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit


//class Step {
//    var skippable: Bool
//    var text: String
//    var value: Any?
//
//    init(skippable: Bool, text: String) {
//        self.skippable = skippable
//        self.text = text
//    }
//}

//class ImageStep: Step {
//    var value: UIImage? {
//        return UIImage.init()
//    }
//    
//    func yay() {
//    }
//}

// TODO: Split out steps
protocol Step {
    var skippable: Bool {get}
    var text: String {get}
    var value: ValueType? {get}
    associatedtype ValueType

    func createResultView(value: ValueType) -> UIView
}

struct ImageStep: Step {
    var skippable: Bool
    var text: String
    var value: UIImage?

    func createResultView(value: ValueType) -> UIView {
        let imageView = UIImageView()
        imageView.image = value

        return imageView
    }

}

struct DateStep: Step {
    var skippable: Bool
    var text: String
    var value: Date?

    func createResultView(value: ValueType) -> UIView {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        label.text = dateFormatter.string(from: value)
        label.textColor = ThemeManager.textColor
        label.font = ThemeManager.font.withSize(20)

        return label
    }
}

struct TextStep: Step {
    var skippable: Bool
    var text: String
    var value: String?

    func createResultView(value: ValueType) -> UIView {
        let label = UILabel()
        label.text = value
        label.textColor = ThemeManager.textColor
        label.font = ThemeManager.font.withSize(20)

        return label
    }
}

struct CustomStep: Step {
    var skippable: Bool
    var text: String
    var value: Any?
    var viewForValue: ((Any) -> UIView)

    func createResultView(value: ValueType) -> UIView {
        return viewForValue(value)
    }
}

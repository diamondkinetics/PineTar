//
//  PineTar
//  Step.swift
//
//  Created by Tommy Martin on 5/9/18.
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

enum State {
    case incomplete
    case complete
    case current
}

public protocol EnableStepDelegate {
    func enableStep(step: Step)
    func disableStep(step: Step)
}

open class Step: NSObject {
    var skippable: Bool
    var text: String
    public var value: Any?
    var resultView: UIView?
    var delegate: EnableStepDelegate? { didSet {correct()} }
    var readyToContinue: Bool { didSet { correct() }}
    var state: State = .incomplete { didSet {if self.state == .current { select() }} }
    
    // Need action
    public init(skippable: Bool, text: String) {
        self.skippable = skippable
        self.text = text
        readyToContinue = skippable
    }
    
    private func correct() {
        guard !skippable else {return}
        
        if readyToContinue {
            delegate?.enableStep(step: self)
        } else {
            delegate?.disableStep(step: self)
        }
    }
    
    func createView(vc: UIViewController) -> UIView {
        return UIView()
    }
    
    func select() {
        resultView?.becomeFirstResponder()
    }
    func deselect() {
        resultView?.resignFirstResponder()
    }
}

public class ImageStep: Step, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var vc: UIViewController!
    private lazy var imageView: MaterialCardView = MaterialImageCardView(frame: CGRect.zero)
    private lazy var tempView: UIView = UIView()
    
    override func createView(vc: UIViewController) -> UIView {
        resultView?.removeFromSuperview()
        self.vc = vc
        let view = UIView()
        
        let image = UIImage(named: "outline_photo_white_48pt", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        tempView.backgroundColor = UIColor.gray
        tempView.layer.cornerRadius = 4
        let tempImageView = UIImageView(image: image)
        tempImageView.image = image
        tempImageView.tintColor = UIColor.white
        tempView.addSubview(tempImageView)
        imageView.addSubview(tempView)
        
        tempImageView.snp.makeConstraints{make in
            make.width.height.equalTo(60)
            make.centerX.centerY.equalToSuperview()
        }
        
        tempView.snp.makeConstraints{make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        imageView.update(forConfig: MaterialCardConfig(cornerRadius: 10, headerConfig: HeaderConfig(header: "")))
        imageView.cardPressedAction = {card in
            self.imageTapped()
        }

        view.addSubview(imageView)
        imageView.snp.makeConstraints{make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(imageView.snp.height)
            make.centerX.equalToSuperview()
        }
        
        self.resultView = view
        return view
    }
    
    @objc func imageTapped() {
        let imagePicker = UIImagePickerController()
        guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else {return}
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        vc.present(imagePicker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        if tempView.superview != nil {tempView.removeFromSuperview()}
        self.value = image
        readyToContinue = true
        vc.dismiss(animated: true, completion: nil)
        imageView.update(forConfig: MaterialCardConfig(dividerConfig: DividerConfig(divideImage: image)))
    }
}

public class TextStep: Step, UITextFieldDelegate {
    override func createView(vc: UIViewController) -> UIView {
        resultView?.removeFromSuperview()
        if value == nil {value = ""}
        
        let label = UITextField()
        label.delegate = self
        label.text = value as? String
        label.textColor = ThemeManager.onSurfaceColor
        label.textAlignment = .center
        label.font = ThemeManager.font.withSize(24)
        label.autocorrectionType = .no
        label.autocapitalizationType = .none
        self.resultView = label
        
        return label
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        readyToContinue = !(result.count == 0)
        self.value = result
        return true
    }
}

public class NumberStep: Step, UITextFieldDelegate {
    override func createView(vc: UIViewController) -> UIView {
        resultView?.removeFromSuperview()
        let textField = UITextField()
        textField.delegate = self
        textField.textColor = ThemeManager.onSurfaceColor
        textField.textAlignment = .center
        textField.font = ThemeManager.font.withSize(24)
        textField.keyboardType = .numberPad
        self.resultView = textField
        
        return textField
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        readyToContinue = !(result.count == 0)
        self.value = Int(result)
        return true
    }
}

public class DateStep: Step {
    private lazy var picker: UIDatePicker = UIDatePicker()
    private lazy var label = UILabel()

    private var vc: UIViewController?
    
    override func createView(vc: UIViewController) -> UIView {
        self.vc = vc
        
        label.textColor = ThemeManager.onSurfaceColor
        label.textAlignment = .center
        label.font = ThemeManager.font.withSize(24)
        updateLabel()
        
        return label
    }
    
    private func updateLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        label.text = dateFormatter.string(from: self.value as? Date ?? Date())
    }
    
    override func select() {
        guard let vc = vc else { return }
        picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.backgroundColor = UIColor.white
        picker.date = self.value as? Date ?? Date()
        picker.addTarget(self, action: #selector(dateChange(sender:)), for: .valueChanged)

        vc.view.addSubview(picker)
        picker.snp.makeConstraints{make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
    override func deselect() {
        if picker.superview == nil { return }
        picker.removeFromSuperview()
    }
    
    @objc func dateChange(sender: UIDatePicker) {
        self.value = sender.date
        updateLabel()
    }
}

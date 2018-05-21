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


public class Step: NSObject {
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
    
    func createView(vc: UIViewController) -> UIView {
        return UIView()
    }
    
    func select() {}
    func deselect() {}
}

public class ImageStep: Step, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var vc: UIViewController!
    private var imageView: MaterialCardView!
    
    override func createView(vc: UIViewController) -> UIView {
        resultView?.removeFromSuperview()
        self.vc = vc
        let view = UIView()
        
        let imageView = MaterialImageCardView(frame: CGRect.zero)
        imageView.backgroundColor = UIColor.gray
        let image = UIImage(named: "outline_photo_white_48pt", in: Bundle(for: type(of: self)), compatibleWith: nil)
        imageView.update(forConfig: MaterialCardConfig(cornerRadius: 10, dividerConfig: DividerConfig(divideImage: image), headerConfig: HeaderConfig(header: "")))
        self.imageView = imageView
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
        vc.dismiss(animated: true, completion: nil)
        imageView.update(forConfig: MaterialCardConfig(dividerConfig: DividerConfig(divideImage: image)))
    }
}

public class TextStep: Step {
    override func createView(vc: UIViewController) -> UIView {
        resultView?.removeFromSuperview()
        if value == nil {value = ""}
        
        let label = UITextField()
        label.text = value as? String
        label.textColor = ThemeManager.textColor
        label.textAlignment = .center
        label.font = ThemeManager.font.withSize(18)
        self.resultView = label
        
        return label
    }
}

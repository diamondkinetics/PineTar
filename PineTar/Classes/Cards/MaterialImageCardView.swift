//
//  MaterialImageCardView.swift
//  PineTar
//
//  Created by Tommy Martin on 5/17/18.
//

import Foundation

@IBDesignable
class MaterialImageCardView: MaterialCardView {
    @IBInspectable var muteColor: UIColor? = nil
    @IBInspectable var muteAlpha: CGFloat = 0.33
    
    
    override func setup() {
        configureWithDefaults()
        super.setup()
    }
    
    private func configureWithDefaults() {
        headerAlignment = headerAlignment == -1 ? ImageAlignment.center.rawValue : headerAlignment
        
        if divideImage == nil {
            divideImage = UIImage(named: "stock", in: Bundle(for: type(of: self)), compatibleWith: nil)
        }
        
        divideHeight = 150
        header = header == nil ? "Image Card" : header
        headerColor = headerColor == nil ? UIColor.white : headerColor
        headerSize = headerSize == -1 ? 18 : headerSize
        cornerRadius = cornerRadius == -1 ? 4 : cornerRadius
    }
    
    
    
    override func createDivide() {
        guard let image = divideImage else {return}
        
        let imageView = UIImageView()
        imageView.tintColor = UIColor.white
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.addCornerRadius(radius: self.cornerRadius)
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints {make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        self.divide = imageView

        guard let muteColor = muteColor else {return}
        
        let muteView = UIView()
        muteView.backgroundColor = muteColor
        muteView.addCornerRadius(radius: self.cornerRadius)
        muteView.alpha = muteAlpha
        
        self.addSubview(muteView)
        muteView.snp.makeConstraints{make in
            make.bottom.leading.top.trailing.equalToSuperview()
        }
    }
}

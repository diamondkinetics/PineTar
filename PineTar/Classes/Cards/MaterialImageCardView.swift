//
//  PineTar
//  MaterialImageCardView.swift
//
//  Created by Tommy Martin on 5/17/18.
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

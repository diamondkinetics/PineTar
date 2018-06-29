//
//  PineTar
//  MaterialCard.swift
//
//  Created by Tommy Martin on 5/2/18.
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

enum ImageAlignment: Int {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case overDivideLeft
    case overDivideMiddle
    case overDivideRight
    case center
}

enum ImageStyle: Int {
    case normal
    case circle
    case roundedCorners
}

@IBDesignable
public class MaterialCardView: UIView {
    // Note: This is kind of ugly - but the default values are not set until the setup function.
    // This allows a subclass to be created with defaults that are used just for the purposes of being displayed on the storyboard
    
    @IBInspectable var cornerRadius: CGFloat = -1.0
    
    // Overlay Traits
    @IBInspectable var divideOffset: CGFloat = -1
    @IBInspectable var divideHeight: CGFloat = -1
    @IBInspectable var divideColor: UIColor? = nil
    @IBInspectable var divideImage: UIImage? = nil
    
    // Image Traits
    @IBInspectable var image: UIImage? = nil
    @IBInspectable var imageHeight: CGFloat = -1
    @IBInspectable var imageWidth: CGFloat = -1
    @IBInspectable var imageAlignment: Int = -1
    @IBInspectable var imageStyle: Int = -1
    @IBInspectable var imageVertOffset: Int = -1 //10
    @IBInspectable var imageHorzOffset: Int = -1 //10
    @IBInspectable var imageOutlineWidth: Int = -1
    @IBInspectable var imageOutlineColor: UIColor? = nil
    
    // Header Traits
    @IBInspectable var header: String? = nil
    @IBInspectable var headerColor: UIColor? = nil
    @IBInspectable var headerSize: CGFloat = -1 //24
    @IBInspectable var headerAlignment: Int = -1
    @IBInspectable var headerVertOffset: Int = -1 //10
    @IBInspectable var headerHorzOffset: Int = -1 //10
    
    // Subheader Traits
    @IBInspectable var subheader: String? = nil
    @IBInspectable var subheaderColor: UIColor? = nil
    @IBInspectable var subheaderSize: CGFloat = -1 //16
    
    @IBInspectable var contentDescription: String? = nil
    @IBInspectable var contentDescriptionOffset: Int = -1 //10
    @IBInspectable var contentDescriptionSize: CGFloat = -1 //12
    @IBInspectable var contentDescriptionColor: UIColor? = nil //UIColor.black
    
    var customViewCreator: (() -> UIView)?
    var customView: UIView?
    var customViewHeight: CGFloat?
    var customViewTopConstraint: CGFloat?
    private var customViewOffset: CGFloat = 0
    
    var divide: UIView?
    var ogHeight: CGFloat? // TODO: Remove ogHeight ... use ogFrame
    var ogFrame: CGRect?
    private var headerLabel: UILabel?
    private var subheaderLabel: UILabel?
    private var descriptionTV: UITextView?
    private var imageView: UIImageView?
    
    public var cardPressedAction: ((MaterialCardView) -> Void)?
    public var pressAnimationEnabled: Bool = true

    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        
        if divideOffset == 0 {
            divide?.layer.cornerRadius = cornerRadius
            
            if #available(iOS 11.0, *) {
                divide?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
        }
    }
    
    func setup() {
        setDefaults()
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = ThemeManager.surfaceColor
        self.addShadow()
        
        createDivide()
        createImage()
        createHeader()
        createSubheader()
        createDescription()
        
        if let customViewCreator = customViewCreator, let height = self.customViewHeight, let top = self.customViewTopConstraint {
            createCustomView(customViewDescription: CustomViewConfig(customView: customViewCreator, height: height, topConstraint: top))
        }
    }
    
    // MARK: Updates
    func update(forConfig config: MaterialCardConfig) {
        // TODO: Complete this - Right now only updating content
        self.backgroundColor = config.backgroundColor
        
        if let divideConfig = config.dividerConfig {
            updateDivide(divideConfig: divideConfig)
        }
        
        if let imageConfig = config.imageConfig {
            updateImage(imageConfig: imageConfig)
        }
        
        if let headerConfig = config.headerConfig {
            updateHeaders(headerConfig: headerConfig)
        }
        
        if let descriptionConfig = config.descriptionConfig {
            updateDescription(descriptionConfig: descriptionConfig)
        }
        
        if let customViewConfig = config.customViewConfig {
            createCustomView(customViewDescription: customViewConfig)
        }
    }
    
    private func updateDivide(divideConfig: DividerConfig) {
        if let divideColor = divideConfig.divideColor {self.divideColor = divideColor}
        if let divideImage = divideConfig.divideImage {self.divideImage = divideImage}
        if let divideHeight = divideConfig.divideHeight {self.divideHeight = divideHeight}
        if let divideOffset = divideConfig.divideOffset {self.divideOffset = divideOffset}
        
        if divide == nil {
            createDivide()
        } else {
            divide?.backgroundColor = divideColor
            (divide as? UIImageView)?.image = self.divideImage
        }
    }
    
    private func updateImage(imageConfig: ImageConfig) {
        if let image = imageConfig.image {self.image = image}
        if let imageStyle = imageConfig.imageStyle {self.imageStyle = imageStyle}
        if let imageHeight = imageConfig.imageHeight {self.imageHeight = imageHeight}
        if let imageWidth = imageConfig.imageWidth {self.imageWidth = imageWidth}
        if let imageAlignment = imageConfig.imageAlignment {self.imageAlignment = imageAlignment}
        if let imageVertOffset = imageConfig.imageVertOffset {self.imageVertOffset = imageVertOffset}
        if let imageHorzOffset = imageConfig.imageHorzOffset {self.imageHorzOffset = imageHorzOffset}
        if let imageOutlineWidth = imageConfig.imageOutlineWidth {self.imageOutlineWidth = imageOutlineWidth}
        if let imageOutlineColor = imageConfig.imageOutlineColor {self.imageOutlineColor = imageOutlineColor}
        
        if imageView == nil {
            createImage()
        } else {
            imageView?.image = self.image
            imageView?.layer.borderWidth = CGFloat(self.imageOutlineWidth)
            imageView?.layer.borderColor = self.imageOutlineColor?.cgColor
        }
    }
    
    private func updateHeaders(headerConfig: HeaderConfig) {
        if let header = headerConfig.header {self.header = header}
        if let headerSize = headerConfig.headerSize {self.headerSize = headerSize}
        if let headerColor = headerConfig.headerColor {self.headerColor = headerColor}
        if let headerAlignment = headerConfig.headerAlignment {self.headerAlignment = headerAlignment}
        if let headerVertOffset = headerConfig.headerVertOffset {self.headerVertOffset = headerVertOffset}
        if let headerHorzOffset = headerConfig.headerHorzOffset {self.headerHorzOffset = headerHorzOffset}

        if let subheader = headerConfig.subheader {self.subheader = subheader}
        if let subheaderColor = headerConfig.subheaderColor {self.subheaderColor = subheaderColor}
        if let subheaderSize = headerConfig.subheaderSize {self.subheaderSize = subheaderSize}
        
        if headerLabel == nil {
            createHeader()
        } else {
            headerLabel?.text = self.header
            headerLabel?.textColor = self.headerColor

        }
        
        if subheaderLabel == nil {
            createSubheader()
        } else {
            subheaderLabel?.text = self.subheader
            subheaderLabel?.textColor = self.subheaderColor
        }
    }
    
    private func updateDescription(descriptionConfig: DescriptionConfig) {
        if let contentDescription = descriptionConfig.contentDescription {self.contentDescription = contentDescription}
        if let contentDescriptionOffset = descriptionConfig.contentDescriptionOffset {self.contentDescriptionOffset = contentDescriptionOffset}
        if let contentDescriptionSize = descriptionConfig.contentDescriptionSize {self.contentDescriptionSize = contentDescriptionSize}
        if let contentDescriptionColor = descriptionConfig.contentDescriptionColor {self.contentDescriptionColor = contentDescriptionColor}
        
        if descriptionTV == nil {
            createDescription()
        } else {
            descriptionTV?.text = self.contentDescription
        }
    }
    
    // MARK: Component Creation
    func createDivide() {
        if divideHeight == 0 {return}
        
        var view: UIView
        
        if let image = divideImage {
            let imageView = UIImageView()
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            view = imageView
        } else {
            view = UIView()
            view.backgroundColor = divideColor
        }
        
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        
        if divideOffset == 0 {
            view.layer.cornerRadius = cornerRadius
            
            if #available(iOS 11.0, *) {
                view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
        }
        
        self.addSubview(view)
        view.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(divideOffset)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(divideHeight)
        }
        
        view.layer.masksToBounds = true
        self.divide = view
    }
    
    private func createImage() {
        guard let image = image else {return}
        
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.layer.borderWidth = CGFloat(self.imageOutlineWidth)
        imageView.layer.borderColor = self.imageOutlineColor?.cgColor
        styleImage(imageView: imageView)
        self.addSubview(imageView)
        imageView.snp.makeConstraints{(make) in
            make.height.equalTo(self.imageHeight)
            make.width.equalTo(self.imageWidth)
            self.align(make: make, alignment: self.imageAlignment, horzOffset: self.imageHorzOffset, vertOffset: self.imageVertOffset)
        }
        
        self.imageView = imageView
    }
    
    private func createHeader() {
        guard let header = header else {return}
        let label = UILabel()
        label.text = header
        label.textColor = headerColor
        label.font = ThemeManager.font.withSize(headerSize)
        self.addSubview(label)
        label.snp.makeConstraints{(make) in
            self.align(make: make, alignment: self.headerAlignment, horzOffset: self.headerHorzOffset, vertOffset: self.headerVertOffset)
        }
        
        self.headerLabel = label
    }
    
    private func createSubheader() {
        guard let subheader = subheader, let headerLabel = headerLabel else {return}
        let label = UILabel()
        label.text = subheader
        label.textColor = subheaderColor
        label.font = ThemeManager.font.withSize(subheaderSize)
        self.addSubview(label)
        label.snp.makeConstraints{(make) in
            make.leading.equalTo(headerLabel.snp.leading)
            make.top.equalTo(headerLabel.snp.bottom).offset(0)
        }
        
        self.subheaderLabel = label
    }
    
    // TODO: Customize this a little bit beter
    private func createDescription() {
        guard let desc = contentDescription, let divide = divide else {return}
        let label = UITextView()
        label.isUserInteractionEnabled = false
        label.text = desc
        label.textColor = contentDescriptionColor
        label.font = ThemeManager.font.withSize(contentDescriptionSize)
        
        self.addSubview(label)
        label.snp.makeConstraints{(make) in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalTo(divide.snp.bottom).offset(5)
            make.height.equalTo(50)
        }
        
        self.descriptionTV = label
    }
    
    func createCustomView(customViewDescription: CustomViewConfig) {
        let customBuilder = customViewDescription.customView
        let customView = customBuilder()
            
        self.customView?.removeFromSuperview()
        
        self.addSubview(customView)
        self.customViewHeight = customViewDescription.height
        self.customViewTopConstraint = customViewDescription.topConstraint
        
        customView.snp.makeConstraints{make in
            make.trailing.leading.equalToSuperview()
            make.top.equalToSuperview().offset(customViewDescription.topConstraint)
            make.height.equalTo(customViewDescription.height)
        }
        
        self.customView = customView
        self.customViewCreator = customBuilder
    }
    
    public func updateCustomViewHeight(height: CGFloat) {
        self.customViewHeight = height
        guard let topConstraint = self.customViewTopConstraint, let height = self.customViewHeight else { return }
        
        customView?.snp.removeConstraints()
        customView?.snp.makeConstraints{make in
            make.top.equalTo(topConstraint)
            make.leading.equalTo(customViewOffset)
            make.trailing.equalTo(-customViewOffset)
            make.height.equalTo(height)
        }
    }
    
    private func align(make: ConstraintMaker, alignment: Int, horzOffset: Int, vertOffset: Int) {
        guard let safeAlignment = ImageAlignment(rawValue: alignment) else {
            make.top.equalToSuperview().offset(vertOffset)
            make.leading.equalToSuperview().offset(horzOffset)
            return
        }
        
        switch safeAlignment {
        case .topLeft:
            make.top.equalToSuperview().offset(vertOffset)
            make.leading.equalToSuperview().offset(horzOffset)
        case .topRight:
            make.top.equalToSuperview().offset(vertOffset)
            make.trailing.equalToSuperview().offset(-horzOffset)
        case .bottomLeft:
            make.bottom.equalToSuperview().offset(-vertOffset)
            make.leading.equalToSuperview().offset(horzOffset)
        case .bottomRight:
            make.bottom.equalToSuperview().offset(-vertOffset)
            make.trailing.equalToSuperview().offset(-horzOffset)
        case .overDivideLeft:
            make.bottom.equalTo(self.divide!.snp.bottom).offset(-vertOffset)
            make.leading.equalToSuperview().offset(horzOffset)
        case .overDivideMiddle:
            make.bottom.equalTo(self.divide!.snp.bottom).offset(-vertOffset)
            make.centerX.equalToSuperview().offset(horzOffset)
        case .overDivideRight:
            make.bottom.equalTo(self.divide!.snp.bottom).offset(-vertOffset)
            make.trailing.equalToSuperview().offset(-horzOffset)
        case .center:
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func styleImage(imageView: UIImageView) {
        guard let style = ImageStyle(rawValue: imageStyle) else {return}
        
        switch style {
        case .circle:
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = imageWidth / 2
        case .roundedCorners:
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 4
        case .normal:
            break

        }
    }
    
    
    // MARK: Animator
    // TODO: I think I can combine these squeexe functions
    func squeeze(byOffset offset: Int) {
        headerHorzOffset = headerHorzOffset + (headerHorzOffset < 0 ? -1 : 1) * offset
        imageHorzOffset = imageHorzOffset + (imageHorzOffset < 0 ? -1 : 1) * offset
        customViewOffset = customViewOffset + CGFloat(offset)
    }
    
    func updateConstraintsForSqueeze() {
        imageView?.snp.removeConstraints()
        imageView?.snp.makeConstraints{(make) in
            make.height.equalTo(self.imageHeight)
            make.width.equalTo(self.imageWidth)
            self.align(make: make, alignment: self.imageAlignment, horzOffset: self.imageHorzOffset, vertOffset: self.imageVertOffset)
        }
        
        headerLabel?.snp.removeConstraints()
        headerLabel?.snp.makeConstraints{(make) in
            self.align(make: make, alignment: self.headerAlignment, horzOffset: self.headerHorzOffset, vertOffset: self.headerVertOffset)
        }
        
        customView?.snp.removeConstraints()
        customView?.snp.makeConstraints{make in
            make.top.equalTo(customViewTopConstraint!)
            make.leading.equalTo(customViewOffset)
            make.trailing.equalTo(-customViewOffset)
            make.height.equalTo(customViewHeight!)
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ogHeight = self.frame.height
        ogFrame = self.frame
        
        if pressAnimationEnabled {
            UIView.animate(withDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            })
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        cardPressedAction?(self)
        
        if pressAnimationEnabled {
            UIView.animate(withDuration: 0.25, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if pressAnimationEnabled {
            UIView.animate(withDuration: 0.25, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
    
    private func setDefaults() {
        cornerRadius = cornerRadius == -1 ? 0 : cornerRadius
        divideOffset = divideOffset == -1 ? 0 : divideOffset
        divideHeight = divideHeight == -1 ? 0 : divideHeight
        divideColor = divideColor == nil ? UIColor.black : divideColor
        
        imageHeight = imageHeight == -1 ? 0 : imageHeight
        imageWidth = imageWidth == -1 ? 0 : imageWidth
        imageAlignment = imageAlignment == -1 ? 0 : imageAlignment
        imageStyle = imageStyle == -1 ? 0 : imageStyle
        imageVertOffset = imageVertOffset == -1 ? 10 : imageVertOffset
        imageHorzOffset = imageHorzOffset == -1 ? 10 : imageHorzOffset
        imageOutlineColor = imageOutlineColor == nil ? UIColor.white : imageOutlineColor
        imageOutlineWidth = imageOutlineWidth == -1 ? 0 : imageOutlineWidth
        
        headerColor = headerColor == nil ? UIColor.black : headerColor
        headerSize = headerSize == -1 ? 24 : headerSize
        headerAlignment = headerAlignment == -1 ? 0 : headerAlignment
        headerVertOffset = headerVertOffset == -1 ? 10 : headerVertOffset
        headerHorzOffset = headerHorzOffset == -1 ? 10 : headerHorzOffset
        
        subheaderColor = subheaderColor == nil ? UIColor.black : subheaderColor
        subheaderSize = subheaderSize == -1 ? 16 : subheaderSize
        
        contentDescriptionOffset = contentDescriptionOffset == -1 ? 10 : contentDescriptionOffset
        contentDescriptionSize = contentDescriptionSize == -1 ? 12 : contentDescriptionSize
        contentDescriptionColor = contentDescriptionColor == nil ? UIColor.black : contentDescriptionColor
    }
}

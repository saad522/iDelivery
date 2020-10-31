//
//  Extension.swift
//  iDelivery
//
//  Created by mac on 10/27/20.
//

import UIKit

extension UIButton {
	convenience init(_ icon: String,size : CGFloat = 35,color : UIColor = .systemGray) {
		self.init(type: .system)
		self.tintColor = color
		let configuration = UIImage.SymbolConfiguration(pointSize: size, weight: .light, scale: .large)
		self.setImage(UIImage(systemName: icon, withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate), for: .normal)
	}
}
extension UILabel {
	convenience init(text: String, font: UIFont, numberOfLines: Int = 1,textColor : UIColor = .label) {
		self.init(frame: .zero)
		self.text = text
		self.font = font
		self.textColor = textColor
		self.numberOfLines = numberOfLines
	}
}
extension UITextField {
	convenience init(placholder : String,isPassword : Bool = false) {
		self.init(frame : .zero)
		self.attributedPlaceholder = NSAttributedString(string: "\(placholder)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19, weight: .ultraLight)])
		self.borderStyle = .none
		self.isSecureTextEntry = isPassword
	}
}
extension UIImageView {
	convenience init(_ icone : String, size : CGFloat = 16) {
		self.init(frame:.zero)
		self.image = UIImage(systemName: "\(icone)",withConfiguration: UIImage.SymbolConfiguration(pointSize: size, weight: .regular, scale: .large))?.withRenderingMode(.alwaysTemplate)
		self.tintColor = .label
	}
}
extension UIView {
	convenience init(_ color : UIColor = .lightGray) {
		self.init(frame:.zero)
		self.backgroundColor = color
		self.constrainHeight(constant: 1)
	}
}
extension UIView {
	convenience init(shadowOpacity : Float) {
		self.init(frame:.zero)
		self.layer.shadowOpacity = shadowOpacity
		self.layer.shadowRadius = 10
		self.layer.shadowOffset = .init(width: 0, height: 10)
		self.layer.cornerRadius = 5
		self.backgroundColor = .systemBackground
	}
}
extension UIImageView {
	convenience init(cornerRadius: CGFloat) {
		self.init(image: nil)
		self.layer.cornerRadius = cornerRadius
		self.clipsToBounds = true
		self.contentMode = .scaleAspectFill
	}
}

extension UIButton {
	convenience init(title: String) {
		self.init(type: .system)
		self.setTitle(title, for: .normal)
		self.setTitleColor(.label, for: .normal)
		self.titleLabel?.font = UIFont(name: "Avenir-Light", size: 36)
		self.layer.cornerRadius = 5
		self.layer.shadowOpacity = 0.4
		self.layer.shadowRadius = 10
		self.layer.shadowOffset = .init(width: 0, height: 10)
		self.layer.cornerRadius = 5
		self.backgroundColor = .systemBackground
	}
}
extension UIButton {
	convenience init(_ message : String, _ action : String) {
		self.init(type: .system)
		let attribudeTitle = NSMutableAttributedString(string: message, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
		attribudeTitle.append(NSAttributedString(string: action, attributes:
													[NSAttributedString.Key.foregroundColor : UIColor.label,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19, weight: .semibold)]))
		self.setAttributedTitle(attribudeTitle, for: .normal)
	}
}

extension UIColor {
	static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
		return .init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
	}
	
	static let logoColor = UIColor.rgb(red: 25, green: 25, blue: 25)
	static let niceBlue = UIColor.rgb(red: 17, green: 154, blue: 237)
	static let systemColor = UIColor.init(red: 0.9489366412, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
	static let greateBlue = UIColor.rgb(red: 74, green: 150, blue: 233)
	static let iosColor = UIColor.init(red: 0.9492425323, green: 0.9487358928, blue: 0.9704347253, alpha: 1)
	
}

//MARK: advanced  func from stackoverflow 🤓
extension UIImage {
	
	class func textEmbededImage(image: UIImage, string: String, color:UIColor, imageAlignment: Int = 0, segFont: UIFont? = nil) -> UIImage {
		let font = segFont ?? UIFont.systemFont(ofSize: 16.0)
		let expectedTextSize: CGSize = (string as String).size(withAttributes: [NSAttributedString.Key.font: font])
		let width: CGFloat = expectedTextSize.width + image.size.width + 5.0
		let height: CGFloat = max(expectedTextSize.height, image.size.width)
		let size: CGSize = CGSize(width: width, height: height)
		UIGraphicsBeginImageContextWithOptions(size, false, 0)
		let context: CGContext = UIGraphicsGetCurrentContext()!
		context.setFillColor(color.cgColor)
		let fontTopPosition: CGFloat = (height - expectedTextSize.height) / 2.0
		let textOrigin: CGFloat = (imageAlignment == 0) ? image.size.width + 5 : 0
		let textPoint: CGPoint = CGPoint.init(x: textOrigin, y: fontTopPosition)
		string.draw(at: textPoint, withAttributes: [NSAttributedString.Key.font: font])
		let flipVertical: CGAffineTransform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height)
		context.concatenate(flipVertical)
		let alignment: CGFloat =  (imageAlignment == 0) ? 0.0 : expectedTextSize.width + 5.0
		context.draw(image.cgImage!, in: CGRect.init(x: alignment, y: ((height - image.size.height) / 2.0), width: image.size.width, height: image.size.height))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		//	UIGraphicsEndImageContext()
		
		return newImage!
	}
}

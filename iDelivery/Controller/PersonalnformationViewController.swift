//
//  PersonalnformationViewController.swift
//  iDelivery
//
//  Created by mac on 10/30/20.
//

import UIKit


class PersonalnformationViewController: UIViewController {
	let profilePicture = UIImageView(image: #imageLiteral(resourceName: "LmpwZw"))
	let name = UILabel.init(text: "Saad Saissi Hassni", font: .boldSystemFont(ofSize: 16), textColor: .label)
	let phone = UILabel.init(text: "0657890122", font: .boldSystemFont(ofSize: 16), textColor: .label)
	
	let city =  UILabel.init(text: "Tangier", font: .boldSystemFont(ofSize: 16), textColor: .label)
	
	let nameIcon = UIImageView(SFSymbols.fullName)
	let phoneIcon = UIImageView(SFSymbols.phone)
	let cityIcon = UIImageView(SFSymbols.location)
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		createUI()
	}
}


extension PersonalnformationViewController  {
	fileprivate func createUI() {
		view.layer.shadowOpacity = 0.5
		view.layer.shadowRadius  = 10
		view.layer.shadowOffset  = .init(width: 0, height: 10)
		view.layer.cornerRadius  = 5
		view.backgroundColor = .systemBackground
		
		let imageSize : CGFloat = 85
		profilePicture.constrainWidth(constant: imageSize)
		profilePicture.constrainHeight(constant: imageSize)
		profilePicture.layer.cornerRadius = imageSize / 2
		profilePicture.clipsToBounds = true
		profilePicture.layer.borderColor = UIColor.label.cgColor
		profilePicture.layer.borderWidth = 1
		let hStackName = HStackView(arrangedSubviews: [nameIcon,name,UIView()], spacing: 5)
		let hStackPhone = HStackView(arrangedSubviews: [phoneIcon,phone,UIView()], spacing: 5)
		let hStackLoaction = HStackView(arrangedSubviews: [cityIcon,city,UIView()], spacing: 15)
		
		
		
		let vStack = VerticalStackView(arrangedSubviews: [hStackName,hStackPhone,hStackLoaction], spacing: 15)
		
		let hStack = HStackView(arrangedSubviews: [profilePicture,vStack], spacing: 15)
		view.addSubview(hStack)
		hStack.fillSuperview(padding: .init(top: 10, left: 15, bottom: 0, right: 0))
	}
}

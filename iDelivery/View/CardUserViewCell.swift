//
//  CardUserViewCell.swift
//  iDelivery
//
//  Created by mac on 10/28/20.
//

import UIKit


class CardUserViewCell: UICollectionViewCell {
	//MARK: Properties
	//Labels
	let userIcon = UIImageView(cornerRadius: 5)
	let name = UILabel.init(text: "Saad Saissi Hassani", font: UIFont(name: "GeezaPro", size: 16)!, textColor: .label)
	let price = UILabel.init(text: "price: 7$", font: UIFont(name: "GeezaPro", size: 16)!, textColor: .label)
	let city = UILabel.init(text: "City: Rabat", font: UIFont(name: "GeezaPro", size: 16)!, textColor: .label)
	let transport = UILabel.init(text: "transport: ", font: UIFont(name: "GeezaPro", size: 16)!, textColor: .label)
	let returns = UILabel.init(text: "returns: 1$ ", font: UIFont(name: "GeezaPro", size: 16)!, textColor: .label)
	
	//UserState
	let active : UIView = {
		let on = UIView()
		let size : CGFloat = 15
		on.backgroundColor = .systemGreen
		on.constrainHeight(constant: size)
		on.constrainWidth(constant: size)
		on.layer.cornerRadius = size / 2
		return on
	}()
	
	//Icons
	let iconName = UIImageView(SFSymbols.fullName)
	let iconPrice = UIImageView(SFSymbols.currency)
	let iconLocation = UIImageView(SFSymbols.location)
	let iconReturns = UIImageView(SFSymbols.currency)
	let iconTransport = UIImageView(image: #imageLiteral(resourceName: "icons8-motorcycle-delivery-single-box-100"))
	let iconValise = UIImageView(SFSymbols.valise)
	
	//Buttons
	let moreDetails : UIButton = {
		let button = UIButton(type: .system)
		button.constrainHeight(constant: 35)
		button.constrainWidth(constant: 104)
		button.setTitle("More details", for: .normal)
		button.titleLabel?.font = UIFont(name: "GeezaPro", size: 16)!
		button.tintColor = .systemBackground
		button.backgroundColor = .systemTeal
		button.layer.cornerRadius = 5
		button.layer.shadowOpacity = 0.4
		button.layer.shadowRadius  = 8
		button.layer.shadowOffset  = .init(width: 0, height: 10)
		return button
	}()
	
	
	//MARK: LifeCycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		createUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


extension CardUserViewCell {
	fileprivate func createUI() {
		backgroundColor = .systemBackground
		layer.shadowOpacity = 0.5
		layer.shadowRadius  = 10
		layer.shadowOffset  = .init(width: 0, height: 10)
		layer.cornerRadius  = 5
		userIcon.image = #imageLiteral(resourceName: "LmpwZw")
		userIcon.constrainWidth(constant: 85)
		userIcon.constrainHeight(constant: 85)
		iconTransport.constrainWidth(constant: 25)
		iconTransport.constrainHeight(constant: 25)
		
		let hStackName = HStackView(arrangedSubviews: [iconName,name,UIView()], spacing: 5)
		
		let hStackPrice = HStackView(arrangedSubviews: [iconPrice,price,UIView()], spacing: 5)
		
		let hStackLocation = HStackView(arrangedSubviews: [iconLocation,city,UIView()], spacing: 5)
		
		let hStackTransport = HStackView(arrangedSubviews: [iconReturns,returns,UIView()], spacing: 5)
		hStackTransport.alignment = .lastBaseline
//		iconTransport.backgroundColor = .systemYellow
		let hStackRetruns = HStackView(arrangedSubviews: [iconValise,transport,iconTransport,UIView()], spacing: 5)
		
		let vStackLabels = VerticalStackView(arrangedSubviews: [hStackName,hStackTransport,hStackPrice], spacing: 20)
		
		let hStack = HStackView(arrangedSubviews: [userIcon,vStackLabels], spacing: 10)
		
		let mainStack = VerticalStackView(arrangedSubviews: [hStack,hStackLocation,hStackRetruns], spacing: 15)
		
		addSubview(mainStack)
		mainStack.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
		
		addSubview(active)
		active.anchor(top: userIcon.topAnchor, leading: nil, bottom: nil, trailing: userIcon.trailingAnchor,padding: .init(top: -5, left: 0, bottom: 0, right: -5))
	}
}

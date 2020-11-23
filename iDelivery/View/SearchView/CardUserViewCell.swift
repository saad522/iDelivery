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
    var user : User! {
        didSet {
            userIcon.sd_setImage(with: URL(string: user.profileImage), placeholderImage: #imageLiteral(resourceName: "icons8-administrator-male-100"))
            price.text   = "Price : \(user.price) DH"
            returns.text = "Return : \(user.retruns) DH"
            name.text    = "\(user.fullName)"
            city.text    = "\(user.city)"
            if user.transport == 0 {
                iconTransport.image = #imageLiteral(resourceName: "motorcycle").withTintColor(.label).withRenderingMode(.alwaysOriginal)
            } else {
                iconTransport.image = #imageLiteral(resourceName: "car").withTintColor(.label).withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
	
    
	let name      = UILabel(text: "Saad Saissi Hassani")
	let price     = UILabel(text: "price: 7$")
	let city      = UILabel(text: "City: Rabat")
	let transport = UILabel(text: "transport: ")
	let returns   = UILabel(text: "returns: 1$ ")
	
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
    let userIcon = UIImageView(cornerRadius: 5)
	let iconName      = UIImageView(SFSymbols.fullName)
	let iconPrice     = UIImageView(SFSymbols.currency)
	let iconLocation  = UIImageView(SFSymbols.location)
	let iconReturns   = UIImageView(SFSymbols.currency)
	let iconTransport = UIImageView(image: #imageLiteral(resourceName: "motorcycle"))
	let iconValise    = UIImageView(SFSymbols.valise)
    
	
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
    func setFonts(fontName : String) {
        price.font = UIFont(name: fontName, size: 16)
        returns.font = UIFont(name: fontName, size: 16)
        name.font = UIFont(name: fontName, size: 16)
        city.font = UIFont(name: fontName, size: 16)
        transport.font = UIFont(name: fontName, size: 16)
    }
	fileprivate func createUI() {
		backgroundColor = .systemBackground
		layer.shadowOpacity = 0.5
		layer.shadowRadius  = 10
		layer.shadowOffset  = .init(width: 0, height: 10)
		layer.cornerRadius  = 5
        userIcon.image = #imageLiteral(resourceName: "icons8-administrator-male-100").withTintColor(.label).withRenderingMode(.alwaysOriginal)
		userIcon.constrainWidth(constant: 85)
		userIcon.constrainHeight(constant: 85)
		iconTransport.constrainWidth(constant: 25)
		iconTransport.constrainHeight(constant: 25)
		
		let hStackName = HStackView(arrangedSubviews: [iconName,name,UIView()], spacing: 5)
		
		let hStackPrice = HStackView(arrangedSubviews: [iconPrice,price,UIView()], spacing: 5)
		
		let hStackLocation = HStackView(arrangedSubviews: [iconLocation,city,UIView()], spacing: 5)
		
		let hStackReturns = HStackView(arrangedSubviews: [iconReturns,returns,UIView()], spacing: 5)
		hStackReturns.alignment = .lastBaseline
//		iconTransport.backgroundColor = .systemYellow
		let hStackTransport = HStackView(arrangedSubviews: [iconValise,transport,iconTransport,UIView()], spacing: 5)
		
		let vStackLabels = VerticalStackView(arrangedSubviews: [hStackName,hStackReturns,hStackPrice], spacing: 20)
		
		let hStack = HStackView(arrangedSubviews: [userIcon,vStackLabels], spacing: 10)
		
		let mainStack = VerticalStackView(arrangedSubviews: [hStack,hStackLocation,hStackTransport], spacing: 15)
		
		addSubview(mainStack)
		mainStack.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
		
		addSubview(active)
		active.anchor(top: userIcon.topAnchor, leading: nil, bottom: nil, trailing: userIcon.trailingAnchor,padding: .init(top: -5, left: 0, bottom: 0, right: -5))
	}
}

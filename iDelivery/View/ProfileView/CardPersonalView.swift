//
//  CardPersonalView.swift
//  iDelivery
//
//  Created by mac on 11/3/20.
//

import UIKit
class CardPersonalView: UIViewController {
 
	//MARK: Properties
    var user : User! {
        didSet {
            name.text = user.fullName
            phone.text = user.phone
            print("Pohone",user.phone)
            city.text = user.city
            profilePicture.sd_setImage(with: URL(string: user.profileImage), placeholderImage: #imageLiteral(resourceName: "icons8-administrator-male-100"))
        }
    }
    //Profile Picture
    let profilePicture = UIImageView(image: #imageLiteral(resourceName: "LmpwZw"))
	//Profile Info
	let name = UILabel.init(text: "Saad Saissi Hassni", font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)!, textColor: .label)
	let phone = UILabel.init(text: "", font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)!, textColor: .label)
	
	let city =  UILabel.init(text: "Tangier", font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)!, textColor: .label)
	
	//Icons
	let nameIcon = UIImageView(SFSymbols.fullName)
	let phoneIcon = UIImageView(SFSymbols.phone)
	let cityIcon = UIImageView(SFSymbols.location)
	
	//Edit Buttons
	let editProfileButtons : UIButton = {
		let edit = UIButton(type : .system)
		edit.setImage(UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.edit)!, string: "Edite Profile", color: .label, imageAlignment: 0, segFont: .boldSystemFont(ofSize: 12)), for: .normal)
		edit.tintColor = .label
		return edit
	}()
	let editPictureButtons : UIButton = {
		let edit = UIButton(type : .system)
		edit.setImage(UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.editeImage)!, string: "Edite Picture", color: .label, imageAlignment: 0, segFont: .boldSystemFont(ofSize: 12)), for: .normal)
		edit.tintColor = .label
		return edit
	}()
	
    //MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		createUI()
	}
}


extension CardPersonalView  {
	fileprivate func createUI() {
        view.shadow()
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
		let vStackPicture = VerticalStackView(arrangedSubviews: [profilePicture,editPictureButtons], spacing: 5)
		
		let hStack = HStackView(arrangedSubviews: [vStackPicture,vStack], spacing: 15)
		view.addSubview(hStack)
		hStack.fillSuperview(padding: .init(top: 10, left: 15, bottom: 0, right: 0))
		hStack.addSubview(editProfileButtons)
		editProfileButtons.anchor(top: hStack.topAnchor, leading: nil, bottom: nil, trailing: hStack.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 5))
	}
}


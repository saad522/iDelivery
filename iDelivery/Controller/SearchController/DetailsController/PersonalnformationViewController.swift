//
//  PersonalnformationViewController.swift
//  iDelivery
//
//  Created by mac on 10/30/20.
//

import UIKit


class PersonalnformationViewController: UIViewController {
    
    //MARK: Properties
    var user : User? {
        didSet {
            profilePicture.sd_setImage(with: URL(string: user?.profileImage ?? ""), placeholderImage: #imageLiteral(resourceName: "icons8-administrator-male-100"))
            name.text = user?.fullName ?? ""
            city.text = user?.city ?? ""
            phone.text = user?.phone ?? ""
        }
    }
    
	let profilePicture = UIImageView(image: #imageLiteral(resourceName: "LmpwZw"))
	let name      = UILabel.init(text: "Saad Saissi Hassni")
	let phone     = UILabel.init(text: "0657890122")
	let city      = UILabel.init(text: "Tangier")
	
	let nameIcon  = UIImageView(SFSymbols.fullName)
	let phoneIcon = UIImageView(SFSymbols.phone)
	let cityIcon  = UIImageView(SFSymbols.location)
	
 
    //MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFontAndColor()
    }
	override func viewDidLoad() {
		super.viewDidLoad()
		createUI()
	}
}

//MARK: Create UI
extension PersonalnformationViewController  {
    fileprivate func setFontAndColor() {
        let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
        [name,phone,city].forEach({$0.font = UIFont(name: fontName, size: 16)})
    }
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
		
		let hStack = HStackView(arrangedSubviews: [profilePicture,vStack], spacing: 15)
		view.addSubview(hStack)
		hStack.fillSuperview(padding: .init(top: 10, left: 15, bottom: 0, right: 0))
	}
}

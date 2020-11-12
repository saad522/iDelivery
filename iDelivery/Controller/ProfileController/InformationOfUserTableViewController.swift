//
//  InformationOfUserTableViewController.swift
//  iDelivery
//
//  Created by mac on 11/3/20.
//

import UIKit

class InformationOfUserTableViewController: UIViewController {
    
    var user : User? {
        didSet {
            price.text = "\(user?.price ?? "30") DH"
            stock.text = "\(user?.stock ?? "30") DH"
            retrun.text = "\(user?.retruns ?? "30") DH"
            
            if user?.transport == 0 {
                transport.text = "Motorcycle"
            } else {
                transport.text = "Car"
            }
            
            email.text = user?.email
        }
    }
    
    //Separators
    let linePrice     = UIView(.systemGray5)
    let lineReturn    = UIView(.systemGray5)
    let lineStock     = UIView(.systemGray5)
    let lineTransport = UIView(.systemGray5)
    
    let iconEmail     = UIImageView(SFSymbols.email)
    let iconPrice     = UIImageView(SFSymbols.currency)
    let iconRetrun    = UIImageView(SFSymbols.currency)
    let iconStock     = UIImageView(SFSymbols.package)
    let iconTransport = UIImageView(SFSymbols.valise)
    
    let priceLabel = UILabel.init(text: "Price/Order")
    let retrunLabel = UILabel.init(text: "Return/Order")
    let stockLabel = UILabel.init(text: "Stock")
    let emailLabel = UILabel.init(text: "Email")
    let transportLabel = UILabel.init(text: "Transport")
    
    let price = UILabel.init(text: "45 DH")
    let retrun = UILabel.init(text: "30 DH")
    let stock = UILabel.init(text: "10 DH")
    let email = UILabel.init(text: "SaadSaissi@gmail.com")
    let transport = UILabel.init(text: "Motorcycle")
    
	override func viewDidLoad() {
		super.viewDidLoad()
        creatUI()
	}
}

//MARK: Create UI
extension InformationOfUserTableViewController {
    
    func creatUI() {
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 15
        view.constrainHeight(constant: 200)
        //Price
        let hStackPrice = HStackView(arrangedSubviews: [iconPrice,priceLabel,UIView(),price], spacing: 5)
        
        let vStackPrice = VerticalStackView(arrangedSubviews: [hStackPrice,linePrice], spacing: 5)
        
        
        //Retrun
        let hStackReturn = HStackView(arrangedSubviews: [iconRetrun,retrunLabel,UIView(),retrun], spacing: 5)
        
        let vStackReturn = VerticalStackView(arrangedSubviews: [hStackReturn,lineReturn], spacing: 5)
        
        
        //Stock
        let hStackStock = HStackView(arrangedSubviews: [iconStock,stockLabel,UIView(),stock], spacing: 5)
        
        let vStackStock = VerticalStackView(arrangedSubviews: [hStackStock,lineStock], spacing: 5)
        
        //Transport
        let hStackTransport = HStackView(arrangedSubviews: [iconTransport,transportLabel,UIView(),transport], spacing: 5)
        
        let vStackTransport = VerticalStackView(arrangedSubviews: [hStackTransport,lineTransport], spacing: 5)
        
        //Email
        let hStackEmail = HStackView(arrangedSubviews: [iconEmail,emailLabel,UIView(),email], spacing: 5)
        
        let vStackEmail = VerticalStackView(arrangedSubviews: [hStackEmail], spacing: 5)
        
        let stack = VerticalStackView(arrangedSubviews: [vStackPrice,vStackReturn,vStackStock,vStackTransport,vStackEmail], spacing: 15)
        view.addSubview(stack)
        stack.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
}


//
//  PricingInformationCard.swift
//  iDelivery
//
//  Created by mac on 10/30/20.
//

import UIKit



class PricingInformationCard: UICollectionViewCell {
	let pricingInfo = UILabel.init(text: " Pricing Information", font: UIFont(name: "GillSans-Bold", size: 21)!,textColor: .label)
	let pricingTableViewController = PricingTableViewController()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		createUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


extension PricingInformationCard {
	fileprivate func createUI() {
		let vStack = VerticalStackView(arrangedSubviews: [pricingInfo,pricingTableViewController.view], spacing: 5)
		addSubview(vStack)
		vStack.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
	}
}

//
//  PricingTableViewCell.swift
//  iDelivery
//
//  Created by mac on 10/30/20.
//

import UIKit


class PricingTableViewCell: UITableViewCell {
	
	//MARK: Properties
	
	//Label
	let name = UILabel.init(text: "Price", font: .systemFont(ofSize: 20))
	let value = UILabel.init(text: "45 MAD", font: .systemFont(ofSize: 20))
	
	//Icon
	let icon = UIImageView(SFSymbols.currency)
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		createUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension PricingTableViewCell {
	fileprivate func createUI() {
		let hStack = HStackView(arrangedSubviews: [icon,name,UIView(),value], spacing: 5)
		addSubview(hStack)
		hStack.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 10))
	}
}

//
//  ToolsTableViewCell.swift
//  iDelivery
//
//  Created by mac on 10/31/20.
//

import UIKit


class ToolsTableViewCell: UITableViewCell {
	
	//MARK: Properties
	
	//Label
	let name = UILabel.init(text: "Price", font: .systemFont(ofSize: 16))

	let value = UIImageView(SFSymbols.currency)
	
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

extension ToolsTableViewCell {
	fileprivate func createUI() {
		value.constrainWidth(constant: 25)
		value.constrainHeight(constant: 25)
		let hStack = HStackView(arrangedSubviews: [icon,name,UIView(),value], spacing: 5)
		addSubview(hStack)
		hStack.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 10))
	}
}


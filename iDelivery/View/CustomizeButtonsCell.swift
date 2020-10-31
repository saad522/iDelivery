//
//  CustomizeButtonsCell.swift
//  iDelivery
//
//  Created by mac on 10/28/20.
//

import UIKit

class CustomizeButtonsCell: UICollectionViewCell {
	//MARK: Properties
	let actionName = UILabel.init(text: "Filter", font: UIFont(name: "PingFangTC-Semibold", size: 16)!, textColor: .systemBackground)
	let actionIcone = UIImageView(SFSymbols.filter)
	
	
	//MARK: LifeCycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		createUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
		
	}
}

extension CustomizeButtonsCell {
	fileprivate func createUI() {
		layer.shadowOpacity = 0.5
		layer.shadowRadius  = 10
		layer.shadowOffset  = .init(width: 0, height: 10)
		layer.cornerRadius  = 5
		backgroundColor     = .systemTeal
		actionIcone.tintColor = .systemBackground
		let hStack = HStackView(arrangedSubviews: [actionIcone,actionName],spacing: 5)
		addSubview(hStack)
		hStack.centerInSuperview()
	}
}

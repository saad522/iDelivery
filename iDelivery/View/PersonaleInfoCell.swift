//
//  PersonaleInfoCell.swift
//  iDelivery
//
//  Created by mac on 10/30/20.
//

import UIKit


class PersonaleInfoCell: UICollectionViewCell {
	let personaleInfo = UILabel.init(text: " Personal Information", font: UIFont(name: "GillSans-Bold", size: 21)!,textColor: .label)
	let presonaleViewController = PersonalnformationViewController()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		creatUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


extension PersonaleInfoCell {
	fileprivate func creatUI() {
		
		let vStack = VerticalStackView(arrangedSubviews: [personaleInfo,presonaleViewController.view], spacing: 15)
			addSubview(vStack)
			vStack.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
		
	}
}

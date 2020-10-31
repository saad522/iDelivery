//
//  ToolsCardCell.swift
//  iDelivery
//
//  Created by mac on 10/31/20.
//

import UIKit

class ToolsCardCell: UICollectionViewCell {
	let personaleInfo = UILabel.init(text: " Tools Information", font: UIFont(name: "GillSans-Bold", size: 21)!,textColor: .label)
	let presonaleViewController = ToolsTableViewController()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		creatUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


extension ToolsCardCell {
	fileprivate func creatUI() {
		
		let vStack = VerticalStackView(arrangedSubviews: [personaleInfo,presonaleViewController.view], spacing: 5)
			addSubview(vStack)
			vStack.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
		
	}
}


//
//  SearchViewCell.swift
//  iDelivery
//
//  Created by mac on 10/28/20.
//

import UIKit

class SearchViewCell: UICollectionViewCell {
	//MARK: Properties
	let name = UILabel(text: "Casablnca", font: UIFont(name: "Avenir-Book", size: 16)!, textColor: .label)
	
	//MARK: LifeCycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		creatUI()
	}
    
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	
	}
}

extension SearchViewCell {
	fileprivate func creatUI() {
		addSubview(name)
		name.fillSuperview(padding: .init(top: 0, left: 5, bottom: 0, right: 0))
		backgroundColor = .systemBackground
		layer.borderWidth = 1
		layer.borderColor = UIColor.label.cgColor
	}
}

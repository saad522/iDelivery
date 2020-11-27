//
//  ListViewCell.swift
//  iDelivery
//
//  Created by mac on 11/27/20.
//

import UIKit

class ListViewCell: UICollectionViewCell {
    //MARK:Properties
    let name = UILabel.init(text: "Casablanca List",
                            font: .systemFont(ofSize: 15, weight: .bold),
                            textColor: .systemGray)
    let circle = UIView(.systemBlue,35)
    let icon = UIImageView(image :
                            UIImage(systemName: SFSymbols.list,
                                    withConfiguration: UIImage.SymbolConfiguration(
                                        pointSize: 20,
                                        weight: .semibold,
                                        scale: .medium)))
    
    let numberOfItemInList = UILabel.init(text: "25", font: .systemFont(ofSize: 25, weight: .regular))
    
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListViewCell {
    fileprivate func creatUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        icon.tintColor = .white
        circle.addSubview(icon)
        icon.centerInSuperview()
        let hStack = HStackView(arrangedSubviews: [circle,UIView(),numberOfItemInList], spacing: 5)
        let vStack = VerticalStackView(arrangedSubviews: [hStack,name], spacing: 5)
        addSubview(vStack)
        vStack.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
    }
}

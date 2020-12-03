//
//  CreateListViewCell.swift
//  iDelivery
//
//  Created by mac on 12/2/20.
//

import UIKit
class CreateListViewCell : UITableViewCell {
    //MARK:Properties
    var list : List? {
        didSet {
            name.text = list?.name
            circle.backgroundColor = UIColor.color(data: (list?.color)!)
        }
    }
    
    let name = UILabel.init(text: "Casablanca List",
                            font: .systemFont(ofSize: 20, weight: .bold),
                            textColor: .label)
    let circle = UIView(.systemBlue,35)
    let icon = UIImageView(image :
                            UIImage(systemName: SFSymbols.list,
                                    withConfiguration: UIImage.SymbolConfiguration(
                                        pointSize: 20,
                                        weight: .semibold,
                                        scale: .medium)))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style : style,reuseIdentifier: reuseIdentifier)
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CreateListViewCell {
    fileprivate func creatUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        icon.tintColor = .white
        circle.addSubview(icon)
        icon.centerInSuperview()
        let hStack = HStackView(arrangedSubviews: [circle,name], spacing: 5)
        addSubview(hStack)
        hStack.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
    }
}

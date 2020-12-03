//
//  ListDetailViewCell.swift
//  iDelivery
//
//  Created by mac on 11/28/20.
//

import SwiftUI



class ListDetailViewCell: UITableViewCell {
    
    let name = UILabel.init(text: "Marto Mi Sissi")
    let phone = UILabel.init(text: "0908")
    //Profile Picture
    let profilePicture = UIImageView(image: #imageLiteral(resourceName: "icons8-administrator-male-100").withTintColor(.label).withRenderingMode(.alwaysOriginal))
    let iconName = UIImageView(SFSymbols.fullName)
    let iconPhone = UIImageView(SFSymbols.phone)

    var item : Item! {
        didSet {
            name.text = item.name ?? "Tnaket"
            phone.text = item.phone ?? "dont't have one"
            profilePicture.sd_setImage(with: URL(string: item.image!),placeholderImage: #imageLiteral(resourceName: "LmpwZw"))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        creatUI()
    }
    fileprivate func creatUI() {
        let hStackName = HStackView(arrangedSubviews: [iconName,name], spacing: 5)
        let hStackPhone = HStackView(arrangedSubviews: [iconPhone,phone], spacing: 5)
        let vStack = VerticalStackView(arrangedSubviews: [hStackName,hStackPhone], spacing: 5)
        let hStack = HStackView(arrangedSubviews: [profilePicture,vStack], spacing: 5)
        let imageSize : CGFloat = 85
        profilePicture.constrainWidth(constant: imageSize)
        profilePicture.constrainHeight(constant: imageSize)
        profilePicture.layer.cornerRadius = imageSize / 2
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderColor = UIColor.label.cgColor
        profilePicture.layer.borderWidth = 1
        addSubview(hStack)
        hStack.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

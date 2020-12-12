//
//  MoreLikesViewCell.swift
//  iDelivery
//
//  Created by mac on 12/11/20.
//

import UIKit

class MoreLikesViewCell: UICollectionViewCell {
    var user : User! {
        didSet {
            profile.sd_setImage(with: URL(string: user.profileImage), placeholderImage: #imageLiteral(resourceName: "icons8-administrator-male-100"))
            price.text = "MAD \(user.price).00"
            city.text  = user.city
            name.text  = user.fullName
        }
    }
    
    let profile = UIImageView(image : #imageLiteral(resourceName: "Image 2"))
    let price = UILabel.init(text: "MAD 15.00", font: .systemFont(ofSize: 15, weight: .semibold))
    let name = UILabel.init(text: "Ragnar Lothbroke", font: .systemFont(ofSize: 19, weight: .semibold))
    let city = UILabel.init(text: "Casablanca", font: .systemFont(ofSize: 15, weight: .semibold))
    let cityIcon = UIImageView(SFSymbols.location,size: 15)
    private let size : CGFloat = 80
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoreLikesViewCell {
    fileprivate func customizeProfileImage() {
        name.textAlignment = .center
        profile.constrainWidth(constant: size)
        profile.constrainHeight(constant: size)
        profile.layer.cornerRadius = size / 2
        profile.layer.borderWidth = 2
        profile.clipsToBounds = true
        profile.layer.borderColor = #colorLiteral(red: 0.1752284169, green: 0.5892119408, blue: 0.9405055642, alpha: 1)
    }
    
    fileprivate func creatUI() {
        layer.cornerRadius = 10
        backgroundColor = .secondarySystemBackground
        customizeProfileImage()
        let hStackCity = HStackView(arrangedSubviews: [cityIcon,city], spacing: 5)
        let vStack = VerticalStackView(arrangedSubviews: [profile,name,hStackCity,price], spacing: 5)
        addSubview(vStack)
        vStack.alignment = .center
        vStack.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
    }
}

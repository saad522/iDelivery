//
//  MesServicesViewCell.swift
//  iDelivery
//
//  Created by mac on 12/11/20.
//

import UIKit


class MesServicesViewCell: UICollectionViewCell {
    
    var service : Service! {
        didSet {
            label.text = service.name
            icon.image = service.image
        }
    }
    
    let label = UILabel.init(text: "Cash on delivery", font: .systemFont(ofSize: 15, weight: .semibold),numberOfLines: 2, textColor: .label)
    let icon = UIImageView(image : #imageLiteral(resourceName: "icons8-delivery-scooter-100"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MesServicesViewCell {
    fileprivate func creatUI() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 15
        addSubview(icon)
        addSubview(label)
        icon.constrainWidth(constant: 55)
        icon.constrainHeight(constant: 55)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: icon.bottomAnchor,constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.textAlignment = .center
        layer.cornerRadius = 15
    }
}

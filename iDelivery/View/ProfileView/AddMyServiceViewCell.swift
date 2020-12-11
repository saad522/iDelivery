//
//  AddMyServiceViewCell.swift
//  iDelivery
//
//  Created by mac on 12/9/20.
//

import UIKit

class AddMyServiceViewCell: UICollectionViewCell {
    
    var service : Service! {
        didSet {
            serviceImage.image  = service.image
            sevrviceName.text   = service.name
        }
    }
    
    let serviceImage = UIImageView(image : #imageLiteral(resourceName: "icons8-delivery-scooter-100"))
    let sevrviceName  = UILabel.init(text: "Cash on Delivery", font: .systemFont(ofSize: 16, weight: .semibold), textColor: .label)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        creatUI()
    }
    
    fileprivate func creatUI() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        serviceImage.constrainHeight(constant: 35)
        serviceImage.constrainWidth(constant: 35)
        let stack = VerticalStackView(arrangedSubviews: [serviceImage,sevrviceName], spacing: 20)
        stack.alignment = .leading
        addSubview(stack)
        serviceImage.contentMode = .scaleAspectFit
        stack.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 0))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

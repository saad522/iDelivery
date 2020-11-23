//
//  CompositionalHeader.swift
//  iDelivery
//
//  Created by mac on 11/23/20.
//

import UIKit
class CompositionalHeader: UICollectionReusableView {
    
    let label = UILabel.init(text: "Color", font: .systemFont(ofSize: 20, weight: .semibold))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.fillSuperview(padding: .init(top: 10, left: 10, bottom: 0, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

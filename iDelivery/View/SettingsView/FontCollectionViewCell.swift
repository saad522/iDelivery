//
//  FontCollectionViewCell.swift
//  iDelivery
//
//  Created by mac on 11/19/20.
//

import UIKit

class FontCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet{
            backView.backgroundColor = isSelected ? .white : .black
            fontText.textColor = isSelected ? .black : .white
        }
    }
    
    let backView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 22.5
        v.backgroundColor = .black
        return v
    }()
    
    let fontText:UILabel = {
        let l = UILabel()
        l.text = "Aa"
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FontCollectionViewCell {
    fileprivate func creatUI() {
        addSubview(backView)
        backView.addSubview(fontText)
        backView.pin(to: self)
        setUpConstraints()
    }
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            fontText.centerYAnchor.constraint(equalTo: centerYAnchor),
            fontText.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

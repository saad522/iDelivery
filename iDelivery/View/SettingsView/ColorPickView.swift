//
//  ColorPickView.swift
//  iDelivery
//
//  Created by mac on 11/18/20.
//

import UIKit

class ColorPickView: UICollectionViewCell {
    
    
    
    let flower  = UIImageView(image : #imageLiteral(resourceName: "1f338"))
    let octupus = UIImageView(image : #imageLiteral(resourceName: "1f419"))
    let fire    = UIImageView(image : #imageLiteral(resourceName: "1f525"))
    let avocado = UIImageView(image : #imageLiteral(resourceName: "1f951"))
    let heart   = UIImageView(image : #imageLiteral(resourceName: "1f499"))
    let star    = UIImageView(image : #imageLiteral(resourceName: "2b50"))
    
    let pink   = UIView(.systemPink,40)
    let purple = UIView(.systemPurple,40)
    let orange = UIView(#colorLiteral(red: 0.9555904269, green: 0.3629895449, blue: 0.1352315545, alpha: 1),40)
    let green  = UIView(.systemGreen,40)
    let blue   = UIView(.systemBlue,40)
    let yellow = UIView(#colorLiteral(red: 1, green: 0.6766466498, blue: 0.1204051599, alpha: 1),40)
    
    let checkmarkPink   = UIImageView.init(SFSymbols.checkmark)
    let checkmarkPurple = UIImageView.init(SFSymbols.checkmark)
    let checkmarkOrange = UIImageView.init(SFSymbols.checkmark)
    let checkmarkGreen  = UIImageView.init(SFSymbols.checkmark)
    let checkmarkBlue   = UIImageView.init(SFSymbols.checkmark)
    let checkmarkYellow = UIImageView.init(SFSymbols.checkmark)

    
  
    override init(frame: CGRect) {
        super.init(frame: .zero)
        creatUI()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColorPickView {
    
    func creatUI() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 5
        let hStackColors = HStackView(arrangedSubviews: [pink,purple,orange,green,blue,yellow])
        let hStackIcons = HStackView(arrangedSubviews: [flower,octupus,fire,avocado,heart,star],spacing: 15)
        let vStack = VerticalStackView(arrangedSubviews: [hStackColors,hStackIcons], spacing: 10)
        addSubview(vStack)
        vStack.centerInSuperview()
        
        checkmarks()
    }
    
    func checkmarks() {
        [checkmarkGreen,checkmarkBlue,checkmarkYellow,checkmarkOrange,checkmarkPurple,checkmarkPink].forEach({$0.isHidden = true })
        [checkmarkGreen,checkmarkBlue,checkmarkYellow,checkmarkOrange,checkmarkPurple,checkmarkPink].forEach({$0.tintColor = .white})
        pink.addSubview(checkmarkPink)
        checkmarkPink.centerInSuperview()
        let tapPink = UITapGestureRecognizer(target: self, action: #selector(handlePink))
        pink.addGestureRecognizer(tapPink)
       
        purple.addSubview(checkmarkPurple)
        checkmarkPurple.centerInSuperview()
        let tapPurple = UITapGestureRecognizer(target: self, action: #selector(handlePurple))
        purple.addGestureRecognizer(tapPurple)
        
        orange.addSubview(checkmarkOrange)
        checkmarkOrange.centerInSuperview()
        let tapOrange = UITapGestureRecognizer(target: self, action: #selector(handleOrange))
        orange.addGestureRecognizer(tapOrange)
        
        blue.addSubview(checkmarkBlue)
        checkmarkBlue.centerInSuperview()
        let tapBlue = UITapGestureRecognizer(target: self, action: #selector(handleBlue))
        blue.addGestureRecognizer(tapBlue)
        
        yellow.addSubview(checkmarkYellow)
        checkmarkYellow.centerInSuperview()
        let tapYellow = UITapGestureRecognizer(target: self, action: #selector(handleYellow))
        yellow.addGestureRecognizer(tapYellow)
        
     
        green.addSubview(checkmarkGreen)
        checkmarkGreen.centerInSuperview()
        let tapGreen = UITapGestureRecognizer(target: self, action: #selector(handleGreen))
        green.addGestureRecognizer(tapGreen)
    }
    
    
    
}

extension ColorPickView {
    @objc func handlePink() {
        [checkmarkGreen,checkmarkBlue,checkmarkYellow,checkmarkOrange,checkmarkPurple].forEach({$0.isHidden = true })
        checkmarkPink.isHidden = false
        UserDefaults.standard.setColor(color: .systemPink, forKey: Keys.key)
    }
    @objc func handleOrange() {
        [checkmarkGreen,checkmarkBlue,checkmarkYellow,checkmarkPurple,checkmarkPink].forEach({$0.isHidden = true })
        checkmarkOrange.isHidden = false
        UserDefaults.standard.setColor(color: #colorLiteral(red: 0.9555904269, green: 0.3629895449, blue: 0.1352315545, alpha: 1), forKey: Keys.key)
    }
    @objc func handleBlue() {
        [checkmarkGreen,checkmarkYellow,checkmarkOrange,checkmarkPurple,checkmarkPink].forEach({$0.isHidden = true })
        checkmarkBlue.isHidden = false
        UserDefaults.standard.setColor(color: .niceBlue, forKey: Keys.key)
    }
    @objc func handleGreen() {
        [checkmarkBlue,checkmarkYellow,checkmarkOrange,checkmarkPurple,checkmarkPink].forEach({$0.isHidden = true })
        checkmarkGreen.isHidden = false
        UserDefaults.standard.setColor(color: .systemGreen, forKey: Keys.key)
    }
    @objc func handleYellow() {
        [checkmarkGreen,checkmarkBlue,checkmarkOrange,checkmarkPurple,checkmarkPink].forEach({$0.isHidden = true })
        checkmarkYellow.isHidden = false
        UserDefaults.standard.setColor(color: #colorLiteral(red: 1, green: 0.6766466498, blue: 0.1204051599, alpha: 1), forKey: Keys.key)
    }
    @objc func handlePurple() {
        [checkmarkGreen,checkmarkBlue,checkmarkYellow,checkmarkOrange,checkmarkPink].forEach({$0.isHidden = true })
        checkmarkPurple.isHidden = false
        UserDefaults.standard.setColor(color: .systemPurple, forKey: Keys.key)
    }
}

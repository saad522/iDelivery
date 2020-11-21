//
//  LanguagePickerView.swift
//  iDelivery
//
//  Created by mac on 11/20/20.
//

import UIKit

class LanguagePickerView: UICollectionViewCell {
    
    let segmentedController : UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Engilsh","Arabic","French"])
//        let appLang =  UserDefaults.standard.string(forKey: Keys.stringKey)
//        if appLang == "en" {
            segment.selectedSegmentIndex = 0
//        } else if appLang == "ar" {
//            segment.selectedSegmentIndex = 1
//        } else if appLang == "fr" {
//            segment.selectedSegmentIndex = 2
//        }
//
//        segment.addTarget(self, action: #selector(setUIMode), for: .valueChanged)
        return segment
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LanguagePickerView {
    fileprivate func creatUI() {
        layer.cornerRadius = 5
        backgroundColor = .secondarySystemBackground
        addSubview(segmentedController)
        segmentedController.centerInSuperview(size: .init(width: 250, height: 0))
    }
    @objc func setUIMode() {
        if segmentedController.selectedSegmentIndex == 0 {
            Bundle.setLanguage(lang: "en")
        } else if segmentedController.selectedSegmentIndex == 1 {
            Bundle.setLanguage(lang: "ar")
        } else {
            Bundle.setLanguage(lang: "fr")
        }
    }
}

//
//  LanguagePickerView.swift
//  iDelivery
//
//  Created by mac on 11/20/20.
//

import UIKit


class LanguagePickerView: UICollectionViewCell {
    
    enum Language {
        static let english = "Engilsh".localized
        static let arabic  = "Arabic".localized
        static let french  = "French".localized
    }
    var didLanguageSet : () -> () = {}
    
    lazy var segmentedController : UISegmentedControl = {
        let segment = UISegmentedControl(items: [Language.english,Language.arabic,Language.french])
        let appLang =  UserDefaults.standard.string(forKey: Keys.stringKey) ?? "en"
        if appLang == "en" {
            segment.selectedSegmentIndex = 0
        } else if appLang == "ar" {
            segment.selectedSegmentIndex = 1
        } else if appLang == "fr" {
            segment.selectedSegmentIndex = 2
        }
        segment.addTarget(self, action: #selector(setUIMode), for: .valueChanged)
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
    @objc func setUIMode(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            print("EN")
            Bundle.setLanguage(lang: "en")
            didLanguageSet()
        } else if segment.selectedSegmentIndex == 1 {
            Bundle.setLanguage(lang: "ar")
            didLanguageSet()
            print("AR")
        } else {
            Bundle.setLanguage(lang: "fr")
            didLanguageSet()
            print("FR")
        }
        
    }
}

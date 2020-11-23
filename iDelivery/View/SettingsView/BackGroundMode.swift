//
//  BackGroundMode.swift
//  iDelivery
//
//  Created by mac on 11/18/20.
//

import UIKit


class BackGroundMode: UICollectionViewCell {
        
    lazy var segmentedController : UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Light","Dark"])
        let index =  UserDefaults.standard.integer(forKey: Keys.intKey)
        segment.selectedSegmentIndex = index
        let tap = UITapGestureRecognizer(target: self , action: #selector(setUIMode))
        segment.addGestureRecognizer(tap)
        return segment
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        creatUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BackGroundMode {
    fileprivate func creatUI() {
        addSubview(segmentedController)
        segmentedController.centerInSuperview(size: .init(width:250, height: 0))
        layer.cornerRadius = 5
        backgroundColor = .secondarySystemBackground
    }
    @objc func setUIMode(gesture : UIGestureRecognizer) {
        if gesture.state == .ended {
            if segmentedController.selectedSegmentIndex == 0 {
                segmentedController.selectedSegmentIndex = 1
                print("THE Segemened is",segmentedController.selectedSegmentIndex )
                UserDefaults.standard.set(1, forKey: Keys.intKey)
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
            } else {
                segmentedController.selectedSegmentIndex = 0
                print("THE Segemened is",segmentedController.selectedSegmentIndex )
                UserDefaults.standard.set(0, forKey: Keys.intKey)
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }
            }
        }
    }
}



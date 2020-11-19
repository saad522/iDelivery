//
//  BackGroundMode.swift
//  iDelivery
//
//  Created by mac on 11/18/20.
//

import UIKit

class BackGroundMode: UIView {
    
    let segmentedController : UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Light","Dark"])
        let index =  UserDefaults.standard.integer(forKey: Keys.intKey)
        segment.selectedSegmentIndex = index
        segment.addTarget(self, action: #selector(setUIMode), for: .valueChanged)
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
        segmentedController.centerInSuperview(size: .init(width:300, height: 0))
        layer.cornerRadius = 5
        backgroundColor = .secondarySystemBackground
    }
    @objc func setUIMode() {
        if segmentedController.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(0, forKey: Keys.intKey)
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        } else {
            UserDefaults.standard.set(1, forKey: Keys.intKey)
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
        
        
        
    }
}

//UIApplication.shared.windows.forEach { window in
//    window.overrideUserInterfaceStyle = .light
//}

//
//  CompositionalHeaderForDetailProfile.swift
//  iDelivery
//
//  Created by mac on 12/11/20.
//

import SwiftUI

class CompositionalHeaderForDetailProfile: UICollectionReusableView {
    let waveFilled = WaveFilled()
    var  dismissDidTaped : () -> Void = {}
    
    let label = UILabel.init(text: "Color", font: .systemFont(ofSize: 20, weight: .semibold))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let hostingHeader = UIHostingController(rootView: waveFilled)
        addSubview(hostingHeader.view)
        hostingHeader.view.fillSuperview()
        hostingHeader.rootView.dismiss = dismiss
    }
    func dismiss() {
        dismissDidTaped()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//
//  CompositionalHeaderForDetailProfile.swift
//  iDelivery
//
//  Created by mac on 12/11/20.
//

import SwiftUI


class CompositionalHeaderForDetailProfile: UICollectionReusableView {
    
    let viewModel = ContactViewModel()
    var randomColor = UIColor()
    
    var  dismissDidTaped : () -> Void = {}
    var random : UIColor! {
        didSet {
            randomColor = random
        }
    }
    
    var user : User! {
        didSet {
            viewModel.name = user.fullName
            viewModel.city = user.city
            viewModel.phone = user.phone
            viewModel.price = user.price
            viewModel.image = user.profileImage
            if user.transport == 0 {
                viewModel.transport = "Motorocyle"
            } else {
                viewModel.transport = "Car"
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let waveFilled = WaveFilled(viewModel: viewModel)
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

//
//  CardUserViewCell.swift
//  iDelivery
//
//  Created by mac on 10/28/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardUserView: View {
    @ObservedObject var viewModel: ContactViewModel
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(.displayP3, white: 0.3, opacity: 0.5), Color(.random),
        ]),startPoint: .bottomLeading, endPoint: .topTrailing).overlay(
            VStack(alignment : .trailing) {
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: SFSymbols.menu2)
                            .font(.system(size: 25.0))
                            .padding(.trailing,15)
                            .foregroundColor(.white)
                    })
                }.padding(.bottom,5)
                
                .padding(.leading,10)
                HStack(alignment : .center) {
                    WebImage(url: URL(string: viewModel.image))
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 75, height: 75, alignment: .leading)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        
                        .padding(5)
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.name)
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .padding(5)
                        HStack {
                            Image(systemName: SFSymbols.location)
                                .foregroundColor(.white)
                            Text(viewModel.city)
                                .foregroundColor(.white)
                            
                        }
                    }
                    .padding(.bottom,5)
                    Spacer()
                }
                .padding(.bottom)
                HStack {
                    VStack {
                        Text("Phone")
                            .foregroundColor(.white)
                        HStack {
                            Image(systemName: SFSymbols.phone)
                                .foregroundColor(.white)
                            Text(viewModel.phone)
                                .fixedSize()
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                    VStack {
                        Text("Tarif")
                            .foregroundColor(.white)
                        HStack {
                            Text("MAD")
                                .foregroundColor(.white)
                            Text(viewModel.price)
                                .fixedSize()
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                    VStack {
                        Text("On")
                            .foregroundColor(.white)
                        Text(viewModel.transport)
                            .fixedSize()
                                .foregroundColor(.white)
                        
                    }
                }
            }
            .padding(.leading,5)
            .padding(.trailing,5)

        
        )
        
    }
}



class CardUserViewCell: UICollectionViewCell {
    //MARK: Properties
    let viewModel = ContactViewModel()
    //Labels
        var user : User! {
            didSet {
                viewModel.image = user.profileImage
                viewModel.price   = "\(user.price).00"
                viewModel.phone = user.phone
                viewModel.name    = user.fullName
                viewModel.city  = user.city
                if user.transport == 0 {
                    viewModel.transport = "Motorcycle"
                } else {
                    viewModel.transport = "Car"
                }
            }
        }
  
    
    
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CardUserViewCell {

    fileprivate func createUI() {
        
        let hostingController = UIHostingController(rootView: CardUserView(viewModel: viewModel))
        addSubview(hostingController.view)
        hostingController.view.layer.cornerRadius = 15
        hostingController.view.clipsToBounds = true
        layer.shadowOpacity = 0.5
        layer.shadowRadius  = 10
        layer.shadowOffset  = .init(width: 0, height: 10)
        hostingController.view.fillSuperview()
        
    }
}

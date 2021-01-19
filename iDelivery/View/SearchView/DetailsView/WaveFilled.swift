//
//  WaveFilled.swift
//  iDelivery
//
//  Created by mac on 12/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        //                        .shadow(color: .white, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? -5: -15, y: configuration.isPressed ? -5: -15)
                        //                        .shadow(color: .black, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? 5: 15, y: configuration.isPressed ? 5: 15)
                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
            )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .foregroundColor(.purple)
            .animation(.spring())
    }
}

class ContactViewModel: ObservableObject {
    @Published var name      = ""
    @Published var city      = ""
    @Published var price     = ""
    @Published var phone     = ""
    @Published var transport = ""
    @Published var image     = ""
}
struct WaveFilled: View {
    var dismiss: (() -> Void)?
    var didPhoneCallTapped : (() -> Void)?
    var didSendSMSTapped   : (() -> Void)?
    var didAddToListTapped    : (() -> Void)?
    
    @ObservedObject var viewModel: ContactViewModel
    
    @State private var randomColor = Color(.random)
    @State private var color : Color = Color(.random)
    @State private var isActionSheetPresented = false
    var body: some View {
       
        ZStack {
            VStack {
                Wave()
                    .fill(color)
                    .onAppear {
                        let baseAnimation = Animation.easeInOut(duration: 0.3).speed(0.1)
                        let repeated = baseAnimation.repeatForever(autoreverses: true)
                        return withAnimation(repeated) {
                            self.color = randomColor
                        }
                    }
                    .frame(height: 280.0)
                    .shadow(color: color, radius:  10, x: 10, y: 5)
                    
                    .overlay(
                        
                        VStack(alignment : .trailing) {
                            HStack {
                                Button(action: dismiss!, label: {
                                    Image(systemName: SFSymbols.dismiss)
                                        .font(.system(size: 25.0))
                                        .padding(.trailing,15)
                                })
                                Spacer()
                                Button(action: didAddToListTapped!, label: {
                                    VStack(alignment : .center) {
                                        Image(systemName: SFSymbols.addMe)
                                            .font(.system(size: 25.0))
                                        Text("Add to list")
                                            .foregroundColor(Color(.systemBackground))
                                            .font(.system(size: 15.0))
                                            .fontWeight(.semibold)
                                    }.padding(.trailing,15)
                                    
                                })
                            }.padding(.bottom,5)
                            .padding(.leading,10)
                            HStack(alignment : .top) {
                                WebImage(url: URL(string: viewModel.image))
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 75, height: 75, alignment: .leading)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .padding(.bottom)
                                    .padding(5)
                                
                                VStack(alignment: .leading) {
                                    Text(viewModel.name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    HStack {
                                        Image(systemName: SFSymbols.location)
                                        Text(viewModel.city)
                                        Spacer()
                                        Button(action: {
                                            isActionSheetPresented = true
                                        }, label: {
                                            
                                            Text("Contact me")
                                                .fontWeight(.semibold)
                                        })
                                        .buttonStyle(NeumorphicButtonStyle(bgColor: .white))
                                        .actionSheet(isPresented: $isActionSheetPresented) {
                                            ActionSheet(title: Text("Contact me By..."), message: Text(""), buttons: [
                                                .default(Text("Phone Call"), action: didPhoneCallTapped!),
                                                .default(Text("Send SMS"), action: didSendSMSTapped!),
                                                .cancel()
                                            ])
                                        }
                                        
                                        .padding(5)
                                    }
                                    
                                }.padding(5)
                            }
                            HStack {
                                VStack {
                                    Text("Phone")
                                    HStack {
                                        Image(systemName: SFSymbols.phone)
                                        Text(viewModel.phone)
                                    }
                                }
                                Spacer()
                                VStack {
                                    Text("Tarif")
                                    HStack {
                                        Text("MAD")
                                        Text(viewModel.price)
                                    }
                                }
                                Spacer()
                                VStack {
                                    Text("On")
                                    HStack {
                                        Text(viewModel.transport)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            //                            Spacer()
                        }
//                        .padding(.top,35)
                        .padding(.leading,5)
                        .padding(.trailing,5)
                        ,alignment: .leading)
                Spacer()
                
            }
            .edgesIgnoringSafeArea(.top)
        }
        .foregroundColor(.white)
    }
}

struct WaveFilled_Previews: PreviewProvider {
    static var previews: some View {
        WaveFilled(viewModel: ContactViewModel())
    }
}

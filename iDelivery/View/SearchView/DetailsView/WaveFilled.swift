//
//  WaveFilled.swift
//  iDelivery
//
//  Created by mac on 12/11/20.
//

import SwiftUI

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
struct WaveFilled: View {
    var dismiss: (() -> Void)?
    var body: some View {
        ZStack {
            VStack {
                Wave()
                    .fill(Color.purple)
                    .frame(height: 280.0)
                    .shadow(color: .purple, radius:  10, x: 10, y: 5)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                    .overlay(
                        
                        VStack(alignment : .trailing) {
                            HStack {
                                Button(action: dismiss!, label: {
                                    Image(systemName: SFSymbols.dismiss)
                                        .font(.system(size: 25.0))
                                        .padding(.trailing,15)
                                })
                                Spacer()
                                Button(action: {}, label: {
                                    Image(systemName: SFSymbols.menu)
                                        .font(.system(size: 25.0))
                                        .padding(.trailing,15)
                                })
                            }.padding(.bottom,5)
                            .padding(.leading,10)
                            HStack(alignment : .top) {
                                Image("LmpwZw")
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 75, height: 75, alignment: .leading)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .padding(.bottom)
                                    .padding(5)
                                
                                VStack(alignment: .leading) {
                                    Text("Saad Saissi Hassni")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    HStack {
                                        Image(systemName: SFSymbols.location)
                                        Text("Agadir")
                                        Spacer()
                                        Button(action: {}, label: {
                                            
                                            Text("Contact me")
                                                .fontWeight(.semibold)
                                        }).buttonStyle(NeumorphicButtonStyle(bgColor: .white))
                                        
                                        .padding(5)
                                    }
                                    
                                }.padding(5)
                            }
                            HStack {
                                VStack {
                                    Text("Phone")
                                    HStack {
                                        Image(systemName: SFSymbols.phone)
                                        Text("0656399124")
                                    }
                                }
                                Spacer()
                                VStack {
                                    Text("Tarif")
                                    HStack {
                                        Text("MAD")
                                        Text("15.00")
                                    }
                                }
                                Spacer()
                                VStack {
                                    Text("On")
                                    HStack {
                                        Text("Motorcycle")
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
        WaveFilled()
    }
}

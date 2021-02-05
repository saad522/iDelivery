//
//  ProfileUserViewController.swift
//  iDelivery
//
//  Created by mac on 2/5/21.
//

import SwiftUI

struct ProfileUserViewController: View {
    @State var isAvailabel = true
   
    var body: some View {
        
        ZStack {
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment : .leading) {
                    VStack {
                        Spacer().frame( height: 15)
                        HStack {
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: SFSymbols.dismiss)
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .accentColor(.red)
                            })
                            Spacer()
                        }.padding(15)
                        HStack {
                           
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: SFSymbols.profile)
                                        .resizable()
                                        .frame(width: 25, height: 25, alignment: .leading)
                                    Text("Saad Saissi Hassani")
                                        .fontWeight(.semibold)
                                }
                                HStack {
                                    Image(systemName: SFSymbols.location)
                                        .resizable()
                                        .frame(width: 25, height: 25, alignment: .leading)
                                    Text("Maroc,Casablanca")
                                        .fontWeight(.semibold)
                                }
                                HStack {
                                    Image(systemName: SFSymbols.phone)
                                        .resizable()
                                        .frame(width: 25, height: 25, alignment: .leading)
                                    Text("+212667300134")
                                        .fontWeight(.semibold)
                                }
                                HStack {
                                   
                                    Toggle(isOn: $isAvailabel, label: {
                                        Circle()
                                            .foregroundColor(isAvailabel ? .green : .gray)
                                            .frame(width: 15, height: 15, alignment: .center)
                                            
                                        Text("Available")
                                            .fontWeight(.semibold)
                                    })
                                }.padding(.horizontal,5)
                            }
                            Spacer()
                            VStack {
                                Image(uiImage: #imageLiteral(resourceName: "LmpwZw"))
                                    .resizable()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .clipShape(Circle())
                                    .shadow(radius: 3.0)
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Text("Edit Profile")
                                        .fontWeight(.semibold)
                                        .accentColor(Color(UIColor.white))
                                        .padding(7)
                                        .background(Color(.systemRed))
                                        .cornerRadius(5)
                                        
                                })
                            }
                            
                        }.padding(10)
                        .frame(width: UIScreen.main.bounds.size.width , height: 130, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        Spacer()
//                        .padding(10)
                        .padding(.bottom,15)
                    }.background(Color(.systemBackground))
                    .ignoresSafeArea(.container, edges: .top)
                    
                    VStack {
                        HStack {
                            Text("Services")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                
                                HStack {
                                    Image(systemName: "square.and.pencil")
                                        .font(.callout)
                                        .accentColor(.red)
                                    Text("Add Service")
                                        .fontWeight(.medium)
                                        .font(.callout)
                                        .accentColor(.red)
                                }
                            })
                        }.padding(.horizontal,10)
                        VStack(alignment : .leading) {
                            HStack {
                              
                                    VStack {
                                        
                                        Image(uiImage: #imageLiteral(resourceName: "icons8-trolley-100"))
                                            .resizable()
                                            .frame(width: 50, height: 50, alignment: .center)
                                        Text("Stockage Gratuit ")
                                            .font(.callout)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.black)
                                            .lineLimit(nil)
                                        
                                    }.frame(width: 100, height: 100)
                                    .padding(5)
                                    .background(Color.white)
                                    .cornerRadius(5.0)
                                VStack {
                                    
                                    Image(uiImage: #imageLiteral(resourceName: "icons8-bank-cards-100"))
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .center)
                                    Text("Transfert Bancaire")
                                        .font(.callout)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                        .lineLimit(nil)
                                    
                                }.frame(width: 100, height: 100)
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(5.0)
                                VStack {
                                    
                                    Image(uiImage: #imageLiteral(resourceName: "icons8-package-100-2"))
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .center)
                                    Text("Retour Gratuit")
                                        .font(.callout)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                        .lineLimit(nil)
                                    
                                }.frame(width: 100, height: 100)
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(5.0)

                            }
                            
                            HStack {
                              
                                    VStack {
                                        
                                        Image(uiImage: #imageLiteral(resourceName: "icons8-delivery-scooter-100"))
                                            .resizable()
                                            .frame(width: 50, height: 50, alignment: .center)
                                        Text("Cash on Delivery")
                                            .font(.callout)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.black)
                                            .lineLimit(nil)
                                        
                                    }.frame(width: 100, height: 100)
                                    .padding(5)
                                    .background(Color.white)
                                    .cornerRadius(5.0)
                                VStack {
                                    
                                    Image(uiImage: #imageLiteral(resourceName: "icons8-food-delivery-100"))
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .center)
                                    Text("Livre Les nouritture")
                                        .font(.callout)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                        .lineLimit(nil)
                                    
                                }.frame(width: 100, height: 100)
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(5.0)
                                VStack {
                                    
                                    Image(uiImage: #imageLiteral(resourceName: "icons8-clinic-100"))
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .center)
                                    Text("Livre Les médicaments")
                                        .font(.callout)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                        .lineLimit(nil)
                                    
                                }.frame(width: 109, height: 100)
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(5.0)

                            }
                        }
                        VStack {
                            HStack {
                                Text("Prices")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    
                                    HStack {
                                        Image(systemName: "square.and.pencil")
                                            .font(.callout)
                                            .accentColor(.red)
                                        Text("Add Price")
                                            .fontWeight(.medium)
                                            .font(.callout)
                                            .accentColor(.red)
                                    }
                                })
                            }.padding(.horizontal, 10)
                            
                            ZStack {
                                Color(.systemBackground)
                                VStack {
                                    HStack {
                                        Image(systemName: SFSymbols.currency)
                                            .resizable()
                                            .frame(width: 20, height: 20, alignment: .leading)
                                        Text("Price per Order")
                                            .font(.callout)
                                        Spacer()
                                        Text("50.00 MAD")
                                            .font(.callout)
                                    }.padding(5)
                                    Spacer()
                                        .frame(width: UIScreen.main.bounds.size.width - 25, height: 1, alignment: .center)
                                        .background(Color(.init(gray: 0.8, alpha: 1.0)))
                                    HStack {
                                        Image(systemName: SFSymbols.currency)
                                            .resizable()
                                            .frame(width: 20, height: 20, alignment: .leading)
                                        Text("Return per Order")
                                            .font(.callout)
                                        Spacer()
                                        Text("00.00 MAD")
                                            .font(.callout)
                                    }.padding(5)
                                    Spacer()
                                        .frame(width: UIScreen.main.bounds.size.width - 25, height: 1, alignment: .center)
                                        .background(Color(.init(gray: 0.8, alpha: 1.0)))
                                    HStack {
                                        Image(systemName: SFSymbols.valise)
                                            .resizable()
                                            .frame(width: 20, height: 20, alignment: .leading)
                                        Text("Transport")
                                            .font(.callout)
                                        Spacer()
                                        Text("Motorcycle")
                                            .font(.callout)
                                    }.padding(5)
                                    Spacer()
                                        .frame(width: UIScreen.main.bounds.size.width - 25, height: 1, alignment: .center)
                                        .background(Color(.init(gray: 0.8, alpha: 1.0)))
                                    HStack {
                                        Image(systemName: SFSymbols.package)
                                            .resizable()
                                            .frame(width: 20, height: 20, alignment: .leading)
                                        Text("Stockage")
                                            .font(.callout)
                                        Spacer()
                                        Text("00.00 MAD")
                                            .font(.callout)
                                    }.padding(5)
                                }
                                .padding(5)
                            }
                        }
                    }
//                    Spacer().frame(width: UIScreen.main.bounds.size.width, height: 100, alignment: .center)
                }
            }).ignoresSafeArea()
            
            
        }
        
    }
}

struct ProfileUserViewController_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUserViewController()
            
    }
}

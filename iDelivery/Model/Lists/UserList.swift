//
//  UserList.swift
//  iDelivery
//
//  Created by mac on 11/28/20.
//

import SwiftUI


struct UserList : Hashable {
    let userID : String
    let name   : String
    let phone  : String
    let image  : String
}

class UserListViewModel: ObservableObject {
    @Published var name = ""
}

//
//  ListDetailViewCell.swift
//  iDelivery
//
//  Created by mac on 11/28/20.
//

import SwiftUI
struct UserListRowView : View {
    @ObservedObject var viewModel = UserListViewModel()
    var body: some View {
        HStack {
            Image(uiImage: #imageLiteral(resourceName: "LmpwZw"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 65.0, height: 65.0)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: SFSymbols.fullName)
                    Text(viewModel.name)
                        .bold()
                }
                HStack {
                    Image(systemName: SFSymbols.phone)
                    Text("06060050550")
                        .foregroundColor(.secondary)
                        .padding(5)
                }

            }.padding(5)
            Spacer()
        }.padding(10)
        
    }
}
class ListDetailViewCell: UITableViewCell {
    let viewModel = UserListViewModel()
    lazy var userListRowView = UserListRowView(viewModel: viewModel)
    var userList : UserList! {
        didSet {
            viewModel.name = userList.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        creatUI()
    }
    fileprivate func creatUI() {
        let controller = UIHostingController(rootView: userListRowView)
        addSubview(controller.view)
        controller.view.fillSuperview()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

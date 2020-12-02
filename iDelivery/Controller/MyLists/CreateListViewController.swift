//
//  CreateListViewController.swift
//  iDelivery
//
//  Created by mac on 12/2/20.
//

import SwiftUI
enum SectionList {
    case main
}
class CreateListDataSource : UITableViewDiffableDataSource<SectionList,List> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        false
    }
}
class CreateListViewController: UITableViewController {
    var users = [List(color: .systemRed, name: "Squad List"),
                 List(color: .systemGreen, name: "Doom Patroll"),
                 List(color: .systemBlue, name: "Gang"),
                 List(color: .systemOrange, name: "Top 10"),
                 List(color: .systemYellow, name: "Candors"),]
    
//    let cancel : UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Cancel", for: .normal)
//        button.setTitleColor(.systemBlue, for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
//        return button
//    }()
//    let done : UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Done", for: .normal)
//        button.setTitleColor(.systemBlue, for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
//        return button
//    }()
//    let titleLable = UILabel(text: "Add To List 📋", font: .systemFont(ofSize: 17, weight: .black))
//    let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold, scale: .medium)
//    lazy var  creatList : UIButton = {
//        let button = UIButton(type : .system)
//        button.setImage(UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.list,withConfiguration: configuration)!, string: "Create New List", color: .white, imageAlignment: 0, segFont: UIFont.systemFont(ofSize: 30, weight: .semibold)), for: .normal)
//        button.layer.cornerRadius = 5
//        button.shadow()
//        button.backgroundColor = .niceBlue
//        return button
//    }()
    
    private let cellID = "CellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        creatUI()

    }
    
    lazy var source : CreateListDataSource = .init(tableView: self.tableView) { (tableView, indexPath, list) -> UITableViewCell? in
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! CreateListViewCell
        cell.list = list
        return cell
    }
    
}

extension CreateListViewController {
    func configureHierarchy() {
        view.backgroundColor = .secondarySystemBackground
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(CreateListViewCell.self, forCellReuseIdentifier: cellID)
        setupSource()
    }
    private func setupSource() {
        var snapshot = source.snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(users,toSection: .main)
        source.apply(snapshot)
    }
    fileprivate func setActions() {
//        creatList.addTarget(self, action: #selector(handleCreateList), for: .touchUpInside)
//        cancel.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
//        let tap = <#value#>
        
    }
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true)
        print("Buggi ...")
    }
    @objc fileprivate func handleCreateList() {
        let creatListViewController = AddListViewController()
        present(creatListViewController, animated: true)
    }
    fileprivate func creatUI() {
        setActions()
//        let hStackTitles = HStackView(arrangedSubviews: [cancel,UIView(),titleLable,UIView(),done], spacing: 5)
//        hStackTitles.distribution = .equalCentering
//        tableView.addSubview(hStackTitles)
//        hStackTitles.translatesAutoresizingMaskIntoConstraints = false
//        hStackTitles.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor).isActive = true
//        hStackTitles.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        hStackTitles.constrainWidth(constant:360)
//        hStackTitles.constrainHeight(constant:35)
//        hStackTitles.centerXInSuperview()

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        dismiss(animated: true)
    }

   
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imagDefauls = UIImageView(image : #imageLiteral(resourceName: "undraw_No_data_re_kwbl"))
        let hStack = HStackView(arrangedSubviews: [UIView(),imagDefauls,UIView()], spacing: 5)
        hStack.distribution = .equalCentering
        imagDefauls.constrainHeight(constant: 200)
        imagDefauls.constrainWidth(constant: 200)
        imagDefauls.isUserInteractionEnabled = true
     if users.count == 0 {
            imagDefauls.isHidden = false
            return hStack
        } else {
            imagDefauls.isHidden = true
            return UIView()
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if users.count == 0 {
            return 400
        }
        return 50
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold, scale: .medium)
            let button = UIButton(type : .system)
            button.setImage(UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.list,withConfiguration: configuration)!, string: "Create New List", color: .white, imageAlignment: 0, segFont: UIFont.systemFont(ofSize: 30, weight: .semibold)), for: .normal)
            button.layer.cornerRadius = 5
            button.shadow()
            button.backgroundColor = .niceBlue
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleCreateList), for: .touchUpInside)
        let randomView = UIView()
        randomView.constrainHeight(constant: 35)
        let vStack = VerticalStackView(arrangedSubviews: [randomView,button], spacing: 10)
        
            return vStack
    
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}
struct CreateListView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let createListViewController = CreateListViewController()
        return createListViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct CreateListViewController_Previews: PreviewProvider {
    static var previews: some View {
        CreateListView()
            .edgesIgnoringSafeArea(.all)
    }
}

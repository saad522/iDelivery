//
//  AddMyServiceViewController.swift
//  iDelivery
//
//  Created by mac on 12/9/20.
//

import SwiftUI

struct Service {
    let image : UIImage
    let name  : String
}
class AddMyServiceViewController: UICollectionViewController {
    
    //MARK:Properties
    
    var services = [
        Service(image: #imageLiteral(resourceName: "icons8-trolley-100"), name: "Stockage gratuit"),
        Service(image: #imageLiteral(resourceName: "icons8-clinic-100"), name: "Livre les médicaments"),
        Service(image: #imageLiteral(resourceName: "icons8-food-delivery-100"), name: "Livre les nouriture"),
        Service(image: #imageLiteral(resourceName: "icons8-delivery-scooter-100"), name: "Cash on delivery"),
        Service(image: #imageLiteral(resourceName: "icons8-package-100-2"), name: "Retour gratuits"),
        Service(image: #imageLiteral(resourceName: "icons8-bank-cards-100"), name: "Transfert bancaire")
    ]
    
   private let mainCellID = "mainCellID"
   private let secondeCellID = "secondeCellID"
   private let headerId = "headerId"
    
    
    init() {
        let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let kind = UICollectionView.elementKindSectionHeader
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: kind, alignment: .topLeading)
        ]
        let layout = UICollectionViewCompositionalLayout(section: section)
         super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}

extension AddMyServiceViewController {
    fileprivate func creatUI() {
        collectionView.backgroundColor = .systemBackground
        conficgureCellRegistretion()
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainCellID, for: indexPath) as! AddMyServiceViewCell
            let service = services[indexPath.item]
            cell.service = service
            return cell
        } else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondeCellID, for: indexPath)
            cell.backgroundColor = .systemYellow
            return cell
        }
           
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CompositionalHeaderViewForService
        return header
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return services.count }
    fileprivate func conficgureCellRegistretion() {
        collectionView.register(AddMyServiceViewCell.self, forCellWithReuseIdentifier: mainCellID)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: secondeCellID)
        collectionView.register(CompositionalHeaderViewForService.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
}

class CompositionalHeaderViewForService: UICollectionReusableView {
    let label : UIButton = {
        let button = UIButton(type : .system)
        button.setTitle("Add Services", for: .normal)
        button.setTitleColor(.niceBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}




struct AddMyServiceView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = AddMyServiceViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
   
}

struct AddMyServiceViewController_Previews: PreviewProvider {
    static var previews: some View {
        AddMyServiceView()
            .edgesIgnoringSafeArea(.all)
    }
}

//
//  NewProfileViewController.swift
//  iDelivery
//
//  Created by mac on 12/9/20.
//

import SwiftUI

class NewProfileViewController: UICollectionViewController & UICollectionViewDelegateFlowLayout {
    var services = [
        Service(image: #imageLiteral(resourceName: "icons8-trolley-100"), name: "Stockage gratuit"),
        Service(image: #imageLiteral(resourceName: "icons8-clinic-100"), name: "Livre les médicaments"),
        Service(image: #imageLiteral(resourceName: "icons8-food-delivery-100"), name: "Livre les nouriture"),
        Service(image: #imageLiteral(resourceName: "icons8-delivery-scooter-100"), name: "Cash on delivery"),
        Service(image: #imageLiteral(resourceName: "icons8-package-100-2"), name: "Retour gratuits"),
        Service(image: #imageLiteral(resourceName: "icons8-bank-cards-100"), name: "Transfert bancaire")
    ]
    private let cellID = "cellID"
    private let secondCellID = "secondCellID"
    private let headerID = "headerID"
    private let headerItemID = "headerItemID"
    init() {
        let layout = UICollectionViewCompositionalLayout { (numberOfSection, _) -> NSCollectionLayoutSection? in
            if numberOfSection == 0 {
                let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0), heightDimension: .absolute(0)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), elementKind: kind, alignment: .top)
                ]
                return section
            } else if numberOfSection == 1 {
                let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
            item.contentInsets = .init(top: 5, leading: 10, bottom: 5, trailing: 10)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: kind, alignment: .top)
                ]
                return section
            } else {
                let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = .init(top: 5, leading: 10, bottom: 15, trailing: 10)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(200)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 77
                section.orthogonalScrollingBehavior = .groupPaging
                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: kind, alignment: .top)
                ]
                return section
            }
        }
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


 extension NewProfileViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerItemID, for: indexPath) as! CompositionalHeader
        header.label.font = .systemFont(ofSize: 25, weight: .heavy)
        header.label.textColor = #colorLiteral(red: 0.2759500146, green: 0.2905508578, blue: 0.2989829779, alpha: 1)
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! CompositionalHeaderForDetailProfile
            header.dismissDidTaped = {
                self.dismiss(animated: true)
            }
            return header
        } else  if indexPath.section == 1 {
            header.label.text = "Mon Services"
            
            return header
        } else {
            header.label.text = "More Like Saad Saissi Hassni"
            return header
        }
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return services.count
        } else {
            return 5
        }
        

    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MesServicesViewCell
            let service = services[indexPath.item]
            cell.service = service
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondCellID, for: indexPath) as! MoreLikesViewCell
            return cell
        }
        
    }
}
private extension NewProfileViewController {

    func creatUI() {
//        let barItem = UIBarButtonItem(title: "", image: UIImage(systemName: SFSymbols.menu)!.withTintColor(.white).withRenderingMode(.alwaysOriginal))
//        navigationItem.rightBarButtonItem = barItem
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        setNavigation()
        
    }
    func setNavigation() {
        collectionView.register(MesServicesViewCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.register(MoreLikesViewCell.self, forCellWithReuseIdentifier: secondCellID)
        
        collectionView.register(CompositionalHeaderForDetailProfile.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerItemID)
    }


    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
}


struct NewProfileView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller =  NewProfileViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct NewProfileViewController_Previews: PreviewProvider {
    static var previews: some View {
        NewProfileView()
            .previewDevice("iPhone SE (2nd generation)")
            .edgesIgnoringSafeArea(.all)
    }
}

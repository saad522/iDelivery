//
//  EditPersonaleInfoViewController.swift
//  iDelivery
//
//  Created by mac on 12/5/20.
//

import SwiftUI
import Firebase


class EditPersonaleInfoViewController: UIViewController {
    var profileViewController : ProfileControllerView?
    //TextFields
    let fullNameText  = UITextField(placholder: "Saad Saissi Hassani")
    let phoneText     = UITextField(placholder: "0605004504")
    let cityText      = UITextField(placholder: "Fes")
    
    //Icons
    private let nameIcon     = UIImageView(SFSymbols.fullName)
    private let phoneIcon    = UIImageView(SFSymbols.phone)
    private let cityIcon     = UIImageView(SFSymbols.location)
    
    //Separators
    private let lineName     = UIView(.systemGray)
    private let linePhone    = UIView(.systemGray)
    private let lineLocation = UIView(.systemGray)
    
    //UIPickeView
    var pickerView = UIPickerView()
    let cities = MountainsController().generateMountains()
    var titles : [String] = []
    
    var personal : User! {
        didSet {
            fullNameText.text = personal.fullName
            phoneText.text    = personal.phone
            cityText.text     = personal.city
        }
    }
    
    //Buttons
    private let updateButton = UIButton.init(title: "Update", .niceBlue, .systemBackground, 36)
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
        setupPickeView()
    }
}
//MARK: SetUp UIPickeView
extension EditPersonaleInfoViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cities.forEach({titles.append($0.name)})
        cityText.text = titles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        cities.forEach({titles.append($0.name)})
        return titles[row]
    }
    fileprivate func setupPickeView() {
        pickerView.delegate    = self
        pickerView.dataSource  = self
        cityText.inputView = pickerView
    }
}
extension EditPersonaleInfoViewController {
    fileprivate func creatUI() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancle", style: .done, target: self, action: #selector(handleCancel))
        let hStackName = HStackView(arrangedSubviews: [nameIcon,fullNameText,UIView()], spacing: 5)
        let vStackName = VerticalStackView(arrangedSubviews: [hStackName,lineName], spacing: 5)
        
        let hStackPhone = HStackView(arrangedSubviews: [phoneIcon,phoneText,UIView()], spacing: 5)
        let vStackPhone = VerticalStackView(arrangedSubviews: [hStackPhone,linePhone], spacing: 5)
        
        let hStacklocation = HStackView(arrangedSubviews: [cityIcon,cityText,UIView()], spacing: 5)
        let vStacklocation = VerticalStackView(arrangedSubviews: [hStacklocation,lineLocation], spacing: 5)
        let stack = VerticalStackView(arrangedSubviews: [vStackName,vStackPhone,vStacklocation], spacing: 40)
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 25, left: 25, bottom: 0, right: 25))
        
        view.addSubview(updateButton)
        updateButton.anchor(top: stack.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 35, left: 25, bottom: 0, right: 25))
        setActions()
        dismissKeyBoard()
    }
    fileprivate func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    func setActions() {
        updateButton.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
    }
    @objc func handleUpdate() {
        let updateAlert =  Alert.alerts(title: "Updating your account...")
        
        guard let name  = fullNameText.text else { return }
        guard let city  = cityText.text else { return }
        guard let phone = phoneText.text else { return }
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let values : [String:Any] = ["city":city,
                                     "fullName":name,
                                     "phone":phone]
        let db = Firestore.firestore()
        db.collection(DB_Keys.collectionKey).document(userId).setData(values,merge: true) { (error) in
            if let error = error {
                print("Error reason : ",error.localizedDescription)
                Alert.showInteractiveAlert(self, with: "Failed To update your information 😶", and: "\(error.localizedDescription)")
                return
            }
            self.present(updateAlert, animated: true)
            print("Its's Done ✅")
            self.profileViewController?.fetchUserData()
            updateAlert.dismiss(animated: true) {
                self.dismiss(animated: true)
            }
        }
    }
}
struct EditPersonaleInfoView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: EditPersonaleInfoViewController())
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct EditPersonaleInfoViewController_Previews: PreviewProvider {
    static var previews: some View {
        EditPersonaleInfoView()
    }
}

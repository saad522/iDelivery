//
//  EditProfilePictureViewController.swift
//  iDelivery
//
//  Created by mac on 12/5/20.
//

import SwiftUI
import Firebase


class EditProfilePictureViewController: UIViewController {
    var profileViewController : ProfileControllerView?
    var picture : User! {
        didSet {
            pictureProfil.sd_setImage(with: URL(string: picture.profileImage))
        }
    }
    
    lazy var pictureProfil : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "LmpwZw")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    let configuration = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold, scale: .small)
    lazy var  changeImage : UIButton = {
        let button = UIButton(type : .system)
        button.setImage(UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.slecteImage,withConfiguration: configuration)!, string: "Change Picture", color: .white, imageAlignment: 0, segFont: UIFont.systemFont(ofSize: 13, weight: .semibold)), for: .normal)
        button.layer.cornerRadius = 5
        button.shadow()
        button.backgroundColor = .niceBlue
        button.tintColor = .white
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePickerImage)))
        return button
    }()
  
    lazy var  saveChanges : UIButton = {
        let button = UIButton(type : .system)
        button.setImage(UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.saved,withConfiguration: configuration)!, string: "Save Picture", color: .white, imageAlignment: 0, segFont: UIFont.systemFont(ofSize: 13, weight: .semibold)), for: .normal)
        button.layer.cornerRadius = 5
        button.shadow()
        button.backgroundColor = .niceBlue
        button.tintColor = .white
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}
//MARK: UIIMAGEPICKERVIEW
extension EditProfilePictureViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @objc func handlePickerImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imgaeEdit = info[.editedImage] as? UIImage else  { return }
        pictureProfil.image = imgaeEdit
        dismiss(animated: true)

        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("HERE")
        dismiss(animated: true)
    }
}
extension EditProfilePictureViewController {
    fileprivate func creatUI() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancle", style: .done, target: self, action: #selector(handleCancel))
        view.addSubview(pictureProfil)
        let imageStack = HStackView(arrangedSubviews: [pictureProfil])
        imageStack.shadow()
        view.addSubview(imageStack)
        imageStack.translatesAutoresizingMaskIntoConstraints = false
        imageStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 25).isActive = true
        imageStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        [changeImage,saveChanges].forEach({$0.constrainHeight(constant: 40)})
        [changeImage,saveChanges].forEach({$0.constrainWidth(constant: 165)})
        imageStack.constrainWidth(constant: 185)
        imageStack.constrainHeight(constant: 185)
        
        let hStack = HStackView(arrangedSubviews: [changeImage,saveChanges], spacing: 25)
        view.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.topAnchor.constraint(equalTo: imageStack.bottomAnchor,constant: 100).isActive = true
        hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        hStack.distribution = .fillEqually
//        hStack.constrainWidth(constant: view.frame.width)

        setActions()
    }
    fileprivate func setActions() {
        saveChanges.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
    }
    @objc fileprivate func handleSaveButton() {
        guard let userID  = Auth.auth().currentUser?.uid else { return }
        let storage = Storage.storage()
        // Create a reference to the file to delete
        let desertRef = storage.reference().child(userID)

        // Delete the file
        desertRef.delete { error in
          if let error = error {
            // Uh-oh, an error occurred!
            print("Error to Delete image reason : ",error.localizedDescription)
            return
          }
        }
        
        let uploadToStorage = storage.reference().child("\(userID).png")
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        if let uploadData = self.pictureProfil.image!.pngData() {
            uploadToStorage.putData(uploadData, metadata: metaData) { (metadata, error) in
                if let error = error {
                    print("Failed To Upload Image  👎🏾reason : ",error.localizedDescription)
                }
                uploadToStorage.downloadURL { (url, error) in
                    if let error = error {
                        print("Failed To download URL of Image 👎🏽 reason : ",error.localizedDescription)
                    }
                    guard let imageURL = url?.absoluteString else {return}
                    let values : [String:Any] = ["profileImage":imageURL]
                    let db = Firestore.firestore()
                    db.collection(DB_Keys.collectionKey).document(userID).setData(values, merge: true) { (error) in
                        if let error = error {
                            print("Failed to set Image Data 👎🏻 reason ",error.localizedDescription)
                            return
                        }
                        print("Its's Done ✅")
                        print("Saved Picture")
                        self.profileViewController?.fetchUserData()
                        self.dismiss(animated: true)
                    }
                }
             
            }
        }
    }
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
}
struct EditProfilePictureView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = EditProfilePictureViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct EditProfilePictureViewController_Previews: PreviewProvider {
    static var previews: some View {
        EditProfilePictureView()
            .edgesIgnoringSafeArea(.all)
    }
}

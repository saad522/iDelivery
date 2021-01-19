//
//  AddListViewController.swift
//  iDelivery
//
//  Created by mac on 11/27/20.
//

import SwiftUI

class AddListViewController: UIViewController, UITextFieldDelegate {
    
    let cancel : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        return button
    }()
    let done : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        return button
    }()
    let titleLable = UILabel(text: "New List 🎨", font: .systemFont(ofSize: 17, weight: .black))
    let circle = UIView(.systemGreen,100)
    let icon   = UIImageView(image :
                            UIImage(systemName: SFSymbols.list,
                                    withConfiguration: UIImage.SymbolConfiguration(
                                        pointSize: 40,
                                        weight: .black,
                                        scale: .medium)))
    lazy var inputListName   : UITextField = {
        let input = UITextField()
        input.font = .systemFont(ofSize: 25, weight: .bold)
        input.textColor = pickedColor
        return input
    }()
    let inputContainer     : UIView = {
        let view = UIView()
        view.constrainHeight(constant: 55)
        view.backgroundColor = .secondarySystemFill
        view.layer.cornerRadius = 15
      return view
    }()
    let clearInputButton   = UIButton(SFSymbols.dismiss,size: 16,color: .systemGray)
    let pink            = UIButton(45,.systemPink)
    let purple          = UIButton(45,.systemPurple)
    let orange          = UIButton(45,.systemOrange)
    let green           = UIButton(45,.systemGreen)
    let blue            = UIButton(45,.systemBlue)
    let yellow          = UIButton(45,.systemYellow)
    let brown           = UIButton(45,#colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1))
    let picked          = UIView(#colorLiteral(red: 0.8784755468, green: 0.8783470988, blue: 0.8869441152, alpha: 1),45)
    let eyedropperIcon  = UIButton(SFSymbols.eyedropper,size: 16,color: .niceBlue)

    var buttons = [UIButton]()
    private var pickedColor = UIColor.systemTeal
    private var colorPicker = UIColorPickerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
        inputListName.delegate = self
        clearInputButton.isHidden = true
        done.alpha = 0.5
        done.isUserInteractionEnabled = false
        colorPicker.delegate = self
    }
    var didAddList : (String,UIColor) -> () = {_,_ in }
    
}
//MARK: set Actions with PickerColor Controller
extension AddListViewController: UIColorPickerViewControllerDelegate {
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc fileprivate func handleAddList() {
        guard let name : String = inputListName.text else {return}
        didAddList(name,pickedColor)
        dismiss(animated: true)
    }
    
    fileprivate func setActions() {
        cancel.addTarget(self, action: #selector(handleCancle), for: .touchUpInside)
        clearInputButton.addTarget(self, action: #selector(handleClearInput), for: .touchUpInside)
        green.addTarget(self, action: #selector(handleGreen), for: .touchUpInside)
        blue.addTarget(self, action: #selector(handleBlue), for: .touchUpInside)
        yellow.addTarget(self, action: #selector(handleYellow), for: .touchUpInside)
        orange.addTarget(self, action: #selector(handleOrange), for: .touchUpInside)
        pink.addTarget(self, action: #selector(handlePink), for: .touchUpInside)
        purple.addTarget(self, action: #selector(handlePurple), for: .touchUpInside)
        brown.addTarget(self, action: #selector(handleBrown), for: .touchUpInside)
        eyedropperIcon.addTarget(self, action: #selector(handlePickerColor), for: .touchUpInside)
        done.addTarget(self, action: #selector(handleAddList), for: .touchUpInside)
    }
    
    func setCircleClor(color : UIColor,button : UIButton) {
        circle.backgroundColor = color
        pickedColor = color
        inputListName.textColor = color
        circle.layer.shadowColor = color.cgColor
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 2
    }
    func removeCircleClor(button : UIButton) {
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.borderWidth = 0
    }
    func buttonAction(sender: UIButton!,color : UIColor){
        for button in buttons {
            button.isSelected = false
            removeCircleClor(button: button)
        }
        sender.isSelected = true
        // you may need to know which button to trigger some action
        // let buttonIndex = buttons.indexOf(sender)
        setCircleClor(color: color, button: sender)
        
    }
    @objc fileprivate func handleGreen(button : UIButton) {
        print("Ima 7na")
        buttonAction(sender: green, color: .systemGreen)
    }
    @objc fileprivate func handleBlue(button : UIButton) {
        print("Ima 7na")
        buttonAction(sender: blue, color: .systemBlue)
    }
    @objc fileprivate func handleOrange(button : UIButton) {
        print("Ima 7na")
        buttonAction(sender: orange, color: .systemOrange)
    }
    @objc fileprivate func handlePink(button : UIButton) {
        print("Ima 7na")
        buttonAction(sender: pink, color: .systemPink)
    }
    @objc fileprivate func handlePurple(button : UIButton) {
        print("Ima 7na")
        buttonAction(sender: purple, color: .systemPurple)
    }
    @objc fileprivate func handleYellow(button : UIButton) {
        print("Ima 7na")
        buttonAction(sender: yellow, color: .systemYellow)
    }
    @objc fileprivate func handleBrown(button : UIButton) {
        print("Ima 7na")
        buttonAction(sender: brown, color: .brown)
    }
    @objc fileprivate func handleClearInput() {
        inputListName.text = ""
        clearInputButton.isHidden = true
        done.alpha = 0.5
        done.isUserInteractionEnabled = false
    }
    @objc fileprivate func handleCancle() {
        dismiss(animated: true)
        print("Dismiss... Button Tapped")
    }
    @objc fileprivate func handlePickerColor() {
        print("Presenting UIPickerColorController...")
        selectColor()
        for button in buttons {
            button.isSelected = false
            removeCircleClor(button: button)
        }
    }
    private func selectColor() {
        colorPicker.supportsAlpha = true
        colorPicker.selectedColor = pickedColor
        self.present(colorPicker, animated: true)
    }
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        pickedColor = viewController.selectedColor
        circle.backgroundColor = pickedColor
        circle.layer.shadowColor = pickedColor.cgColor
        inputListName.textColor = pickedColor
    }
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("Dismiss UIPickerColorController...")
    }
}
extension AddListViewController {
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            if !text.isEmpty{
                clearInputButton.isHidden = false
                done.alpha = 1.0
                done.isUserInteractionEnabled = true
            } else {
                clearInputButton.isHidden = true
                done.alpha = 0.5
                done.isUserInteractionEnabled = false
            }
            return true
        }

    
    fileprivate func creatUI() {
        dismissKeyBoard()
        view.backgroundColor = .systemBackground
        buttons.append(orange)
        buttons.append(yellow)
        buttons.append(blue)
        buttons.append(pink)
        buttons.append(purple)
        buttons.append(green)
        buttons.append(brown)
        let hStackTitles = HStackView(arrangedSubviews: [cancel,UIView(),titleLable,UIView(),done], spacing: 5)
        hStackTitles.distribution = .equalCentering
        view.addSubview(hStackTitles)
        hStackTitles.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 5, left: 5, bottom: 0, right: 5))
        circle.addSubview(icon)
        icon.centerInSuperview()
        icon.tintColor = .white
        circle.shadow(.systemGreen)
        
        let hStackInput = HStackView(arrangedSubviews: [inputListName,clearInputButton], spacing: 5)
        inputContainer.addSubview(hStackInput)
        hStackInput.fillSuperview(padding: .init(top: 5, left: 15, bottom: 5, right: 45))
        clearInputButton.constrainWidth(constant: 25)
        let hStackCircle = HStackView(arrangedSubviews: [UIView(),circle,UIView()], spacing: 5)
        hStackCircle.distribution = .equalCentering
        picked.addSubview(eyedropperIcon)
        eyedropperIcon.centerInSuperview()
//        circleSelected.constrainHeight(constant: 55)
//        circleSelected.constrainWidth(constant: 55)
        let hStackLineOne = HStackView(arrangedSubviews: [pink,purple,orange,green,blue,yellow], spacing: 5)
        let hStackLineTwo = HStackView(arrangedSubviews: [brown,picked,UIView(),UIView(),UIView(),UIView(),UIView()], spacing: 15)
        hStackLineOne.distribution = .equalCentering
        hStackLineTwo.distribution = .equalCentering
        let hStackColor = VerticalStackView(arrangedSubviews: [hStackLineOne,hStackLineTwo], spacing: 15)
        
        let vStack = VerticalStackView(arrangedSubviews: [hStackCircle,inputContainer,hStackColor], spacing: 30)
        
        
        
        view.addSubview(vStack)
        
        
        
        
        vStack.anchor(top: hStackTitles.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 45, left: 15, bottom: 00, right: 15))
        
        setActions()
    }
}









struct AddListView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = AddListViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
   
}

struct AddListViewController_Previews: PreviewProvider {
    static var previews: some View {
            AddListView()
                .edgesIgnoringSafeArea(.all)
         
    }
}

//
//  ProfileViewController.swift
//  PiCKUP
//
//  Created by Hubert Le on 8/5/21.
//

import UIKit
import FirebaseFirestore

class ProfileViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    
    let ageNumber = [1...100]
    var pickerView = UIPickerView()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        ageTextField.inputView = pickerView
        
        view.addSubview(nameTextField)
        view.addSubview(ageTextField)
        
        nameTextField.delegate = self
        ageTextField.delegate = self
        bioTextField.delegate = self
        
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        
        let docRef = db.document("PiCKUP/profile")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            print(data)
        }
    }

// ----- keyboard -----
    func dismiss() {
        self.dismiss(animated:true)
    }
    //!: wrote this all right but taping else where to dissmiss is difficult
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
// ----- Firebase -----
    func saveData(text: String, age: String, bio: String) {
        let docRef = db.document("PiCKUP/profile")
        docRef.setData(["Name": text, "Age": age, "Bio": bio])
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if let name = nameTextField.text,
           let age = ageTextField.text,
           let bio = bioTextField.text,
           !name.isEmpty {
            saveData(text: name, age: age , bio: bio)
        }
    }
// ----- Profile pic ------
    @IBAction func didTapButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 1)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ageTextField.text = String(row + 1)
        ageTextField.resignFirstResponder()
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //print("\(info)")
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

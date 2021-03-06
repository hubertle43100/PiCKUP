//
//  ProfileViewController.swift
//  PiCKUP
//
//  Created by Hubert Le on 8/5/21.
//

import UIKit
import FirebaseFirestore
import Firebase
import AVFoundation

class ProfileViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
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
        phoneTextField.delegate = self
        
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        
        
        let docRef = db.document("PiCKUP/profile")
        let profile = db.collection("profile")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                _ = document.data().map(String.init(describing:)) ?? "nil"
                self.nameTextField.text = "Hubert"
                self.ageTextField.text = "21"
                self.bioTextField.text = "Working on PiCKUP"
                self.phoneTextField.text = "(108)808-5274"
            } else {
                print("Document does not exist")
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    
    
// ----- Phone Text Field -----
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField == phoneTextField) {
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)

            let decimalString = components.joined(separator: "") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.hasPrefix("1")

            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int

                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()

            if hasLeadingOne {
                formattedString.append("1 ")
                index += 1
            }
            if (length - index) > 3 {
                let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("(%@)", areaCode)
                index += 3
            }
            if length - index > 3 {
                let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }

            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
        }
        else {
            return true
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
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
// ----- Firebase -----
    func saveData(text: String, age: String, bio: String, phone: String) {
        let docRef = db.document("PiCKUP/profile")
        docRef.setData(["Name": text, "Age": age, "Bio": bio, "Phone": phone])
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if let name = nameTextField.text,
           let age = ageTextField.text,
           let bio = bioTextField.text,
           let phone = phoneTextField.text,
           !name.isEmpty {
            saveData(text: name, age: age , bio: bio, phone: phone)
        }
    }
// ----- Profile ------
    @IBAction func didTapButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
//    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
//           guard let uid = Auth.auth().currentUser?.uid else { return }
//           let storageRef = Storage.storage().reference().child("user/\(uid)")
//
//           guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
//
//
//           let metaData = StorageMetadata()
//           metaData.contentType = "image/jpg"
//
//           storageRef.putData(imageData, metadata: metaData) { metaData, error in
//               if error == nil, metaData != nil {
//                   if let url = metaData?.downloadURL() {
//                       completion(url)
//                   } else {
//                       completion(nil)
//                   }
//                   // success!
//               } else {
//                   // failed
//                   completion(nil)
//               }
//           }
//       }
    func saveProfile(username:String, profileImageURL:URL, completion: @escaping ((_ success:Bool)->())) {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let databaseRef = Database.database().reference().child("users/profile/\(uid)")
            
            let userObject = [
                "username": username,
                "photoURL": profileImageURL.absoluteString
            ] as [String:Any]
            
            databaseRef.setValue(userObject) { error, ref in
                completion(error == nil)
            }
        }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

// ----- Age scrollwheel -----
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
    
// ----- Profile -----
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

//
//  AddFieldController.swift
//  PiCKUP
//
//  Created by Hubert Le on 8/25/21.
//

import UIKit
import FirebaseFirestore

class AddFieldController: UIViewController {
    let db = Firestore.firestore()
    @IBOutlet weak var LocationTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        func saveData(text: String, location: String) {
            let docRef = db.document("PiCKUP/field")
            docRef.setData(["Name": text, "Location": location])
        }
    
//    @IBAction func saveButton(_ sender: UIButton) {
//        if let name = NameTextField,
//           let locations = LocationTextField,
//           !name.isEmpty {
//            saveData(text: name, location: locations)
//        }
//    }
        
}

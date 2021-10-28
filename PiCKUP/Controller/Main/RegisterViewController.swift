//
//  RegisterViewController.swift
//  PiCKUP
//
//  Created by Hubert Le on 6/10/21.
//

import UIKit
import Firebase
import FirebaseAuth

class ResgisterViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        if email.text?.isEmpty == true {
            print("No text in email field")
            return
        }
        if password.text?.isEmpty == true {
            print("No text in password field")
            return
        }
        resigterUser()
    }
    
    
    func resigterUser() {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                print("Error \(error?.localizedDescription)")
                return
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewController(identifier: "mainMenu")
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!, animated: true)
        }
    }
}

//
//  LoginViewController.swift
//  PiCKUP
//
//  Created by Hubert Le on 6/10/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
  
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        validUser()
    }
    func validUser() {
        if email.text?.isEmpty == true {
            print("No text in email field")
            return
        }
        if password.text?.isEmpty == true {
            print("No text in password field")
            return
        }
        loginUser()
    }
    
    func loginUser() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] authResult, err in
            guard let strongSelf = self else {return}
            if let err = err {
                print(err.localizedDescription)
            }
            self?.checkUser()
        }
    }
    func checkUser() {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewController(identifier: "mainMenu")
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!, animated: true)
        }
    }
}


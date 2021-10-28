//
//  PhoneValidViewController.swift
//  PiCKUP
//
//  Created by Hubert Le on 8/10/21.
//

import UIKit

class PhoneValidViewController: UIViewController {
    
    @IBOutlet weak var codeTextField: OneTimeCodeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.configure()
        codeTextField.becomeFirstResponder()
        codeTextField.didEnterLastDigit = { [self] code in
            let alert = UIAlertController(title: "SUCCESS!", message: "Your phone is now validated amd all set to continue on.", preferredStyle: .alert)
            self.present(alert, animated: true)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
            }))
        }
    }
}

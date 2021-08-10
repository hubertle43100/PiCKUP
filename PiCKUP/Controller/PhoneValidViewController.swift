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
    }
}

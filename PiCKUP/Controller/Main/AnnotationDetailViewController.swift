//
//  AnnotationDetailViewController.swift
//  PiCKUP
//
//  Created by Hubert Le on 10/28/21.
//

import UIKit

class AnnotationDetailViewController: UIViewController {
    var annotation: PinAnnotation!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pinPhoto: UIImageView!
    @IBOutlet weak var historyText: UITextView!
    
    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = annotation.title
        pinPhoto.image = annotation.pinPhoto
        historyText.text = annotation.historyText
    }

    

}


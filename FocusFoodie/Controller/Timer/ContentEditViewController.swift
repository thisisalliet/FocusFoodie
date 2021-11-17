//
//  ContentEditViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/17.
//

import UIKit

class ContentEditViewController: UIViewController {

    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var categoryHandler: ((_ category: UIImage) -> ())?
    
    var contentHandler: ((_ title: String, _ note: String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Button Actions -
    
    @IBAction func onSave(_ sender: UIButton) {
        
        contentHandler?(titleTextField.text ?? "Unset", noteTextField.text ?? "Unset")
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

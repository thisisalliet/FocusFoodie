//
//  SetUpViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/9.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class SetUpViewController: UIViewController {
    
    var db: Firestore!
    
    @IBOutlet weak var setUpTitleLabel: UILabel!
    
    @IBOutlet weak var uniqueIdTextField: UITextField!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet weak var buttonBackground: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        nextButton.isHidden = true
        
        checkUserName()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        guard let correctUniqueId = uniqueIdTextField.text else { return }
        
        db.collection(CollectionName.user.rawValue).addDocument(data: ["unique_id": correctUniqueId]) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
    
    func checkUserName() {
        
        guard let duplicateUniqueId = uniqueIdTextField.text else { return }
                
        let query = db.collection(CollectionName.user.rawValue).whereField("display_id", isEqualTo: duplicateUniqueId)
        
        query.getDocuments { (querySnapshot, error) in
            
            if let error = error {
                
                self.hintLabel.text = String(describing: error)
                
            } else {
                
                if ((querySnapshot?.documents.isEmpty) != nil) {
                    
                    self.nextButton.isHidden = false
                    
                    self.hintLabel.text = "You're good to go!"
                }
            }
        }
    }
}

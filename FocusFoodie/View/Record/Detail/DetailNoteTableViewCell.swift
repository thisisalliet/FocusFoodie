//
//  DescriptionTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import UIKit

class DetailNoteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel! {
        
        didSet {
            
            noteLabel.textColor = UIColor.B5
            
            noteLabel.text = "Note"
        }
    }
    @IBOutlet weak var noteTextField: UITextField! {
        
        didSet {
            
            noteTextField.cornerRadius = 10
            
            noteTextField.textColor = UIColor.B5
            
            noteTextField.placeholder = "Tap to Edit"
        }
    }
}


//@IBOutlet weak var categoryButton: UIButton! {
//
//    didSet {
//
//        categoryButton.backgroundColor = UIColor.B3
//
//        categoryButton.cornerRadius = 10
//
//        categoryButton.setTitle("Coding", for: .normal)
//
//        categoryButton.setTitleColor(UIColor.B4, for: .normal)
//    }
//}

//@IBOutlet weak var dateButton: UIButton! {
//
//    didSet {
//
//        dateButton.backgroundColor = UIColor.B3
//
//        dateButton.cornerRadius = 10
//
//        dateButton.setTitle("2021.10.21", for: .normal)
//
//        dateButton.setTitleColor(UIColor.B5, for: .normal)
//    }
//}

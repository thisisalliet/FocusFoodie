//
//  DescriptionTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import UIKit

class DetailNoteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteTextField: UITextField! {
        
        didSet {
            
            noteTextField.cornerRadius = 10
            
            noteTextField.textColor = UIColor.B5
            
            noteTextField.placeholder = "Tap to Edit"
        }
    }
}

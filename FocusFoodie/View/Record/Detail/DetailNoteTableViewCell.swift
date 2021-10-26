//
//  DescriptionTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import UIKit

class DetailNoteTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryGreyView: UIView! {
        
        didSet {
            
            categoryGreyView.backgroundColor = .L4
            
            categoryGreyView.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var categoryTitleLabel: UILabel! {
        
        didSet {
            
            categoryTitleLabel.text = "CODING"

            categoryTitleLabel.textColor = .white
        }
    }
    
    @IBOutlet weak var noteGreyView: UIView! {
        
        didSet {
            
            noteGreyView.backgroundColor = .B6
            
            noteGreyView.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var noteTitleLabel: UILabel! {
        
        didSet {
            
            noteTitleLabel.text = "NOTE"
            
            noteTitleLabel.textColor = .white
        }
    }
    
    @IBOutlet weak var noteLabel: UILabel! {
        
        didSet {
            
            noteLabel.textColor = UIColor.B5
            
            noteLabel.text = "Coding is hard..."
        }
    }
}

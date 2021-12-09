//
//  DescriptionTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import UIKit

class DetailNoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel!
        
    @IBOutlet weak var categoryButton: UIButton! {
        
        didSet {
            
            categoryButton.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var titleTextfield: UITextField!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var noteTextfield: UITextField!
    
    @IBAction func onEdit(_ sender: UIButton) {
        
    }
    
    func layoutNoteCell(image: UIImage, category: String, title: String?, note: String) {
        
        categoryImage.image = image
        
        categoryButton.setTitle("\(category) (tap to edit)", for: .normal)
                
        titleTextfield.text = title
        
        noteTextfield.text = note
    }
}

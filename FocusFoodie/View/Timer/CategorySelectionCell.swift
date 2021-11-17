//
//  CategorySelectionCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/17.
//

import UIKit

class CategorySelectionCell: UICollectionViewCell {

    @IBOutlet weak var categoryBackground: UIView!
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    func layoutCell(image: UIImage?, title: String) {

//        categoryImage.image = image

//        categoryTitle.text = title
//    }
}

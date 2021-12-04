//
//  RecordTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit

class RecordCell: UITableViewCell {
        
    @IBOutlet weak var timerImageForRecord: UIImageView!
    
    @IBOutlet weak var timeLabelForRecord: UILabel!
    
    @IBOutlet weak var titleLabelForRecord: UILabel!
    
    @IBOutlet weak var categoryImageForRecord: UIImageView!
    
    func layoutCell(timerImage: UIImage?, time: Int, title: String, categoryImage: UIImage?) {
        
        timerImageForRecord?.image = timerImage
        
        timeLabelForRecord.text = "\(time) min"
        
        titleLabelForRecord.text = title
        
        categoryImageForRecord.image = categoryImage
    }
}

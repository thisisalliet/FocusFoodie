//
//  WeekView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/18.
//

import UIKit
import Foundation

class WeekView: UIView {
    
    @IBOutlet var contentView: WeekView!
    
    @IBOutlet weak var mondayButton: UIButton!
    
    @IBOutlet weak var mondayLabel: UILabel!
    
    @IBOutlet weak var mondayDateLabel: UILabel!
    
    @IBOutlet weak var tuesdayButton: UIButton!
    
    @IBOutlet weak var tuesdayLabel: UILabel!
    
    @IBOutlet weak var tuesdayDateLabel: UILabel!
    
    @IBOutlet weak var wednesdayButton: UIButton!
    
    @IBOutlet weak var wednesdayLabel: UILabel!
    
    @IBOutlet weak var wednesdayDateLabel: UILabel!
    
    @IBOutlet weak var thursdayButton: UIButton!
    
    @IBOutlet weak var thursdayLabel: UILabel!
    
    @IBOutlet weak var thursdayDateLabel: UILabel!
    
    @IBOutlet weak var fridayButton: UIButton!
    
    @IBOutlet weak var fridayLabel: UILabel!
    
    @IBOutlet weak var fridayDateLabel: UILabel!
    
    @IBOutlet weak var saturdayButton: UIButton!
    
    @IBOutlet weak var saturdayLabel: UILabel!
    
    @IBOutlet weak var saturdayDateLabel: UILabel!
    
    @IBOutlet weak var sundayButton: UIButton!
    
    @IBOutlet weak var sundayLabel: UILabel!
    
    @IBOutlet weak var sundayDateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initView()
    }
    
    private func initView() {
        
        Bundle.main.loadNibNamed(
            String(describing: WeekView.self),
            owner: self,
            options: nil)
        
        stickSubView(contentView)
    }
}

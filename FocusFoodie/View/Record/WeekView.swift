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
        
        setUpDateLabels()
    }
    
    private func setUpDateLabels() {
        
        var calendar = Calendar.autoupdatingCurrent
        
        calendar.firstWeekday = 2 // Start on Monday (or 1 for Sunday)
        
        let today = calendar.startOfDay(for: Date())
        
        var week = [Date]()
        
        if let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) {
            
            for i in 0...6 {
                if let day = calendar.date(byAdding: .day, value: i, to: weekInterval.start) {
                    week += [day]
                }
            }
            
            let monday = week[0].dateOfWeek()
            
            let tuesday = week[1].dateOfWeek()
            
            let wednesday = week[2].dateOfWeek()
            
            let thursday = week[3].dateOfWeek()
            
            let friday = week[4].dateOfWeek()
            
            let saturday = week[5].dateOfWeek()
            
            let sunday = week[6].dateOfWeek()

            mondayDateLabel.text = "\(monday)"
            
            tuesdayDateLabel.text = "\(tuesday)"
            
            wednesdayDateLabel.text = "\(wednesday)"
            
            thursdayDateLabel.text = "\(thursday)"
            
            fridayDateLabel.text = "\(friday)"
            
            saturdayDateLabel.text = "\(saturday)"
            
            sundayDateLabel.text = "\(sunday)"
        }
    }
}

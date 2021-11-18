//
//  WeekView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/18.
//

import UIKit
import Foundation

protocol WeekViewDelegate: AnyObject {
    
    func changeDate(date: Date)
}

class WeekView: UIView {
    
    private enum Week: Int {

        case monday = 0

        case tuesday = 1

        case wednesday = 2
        
        case thursday = 3

        case friday = 4

        case saturday = 5

        case sunday = 6
    }
    
    @IBOutlet var weekButtons: [UIButton]!
    
    @IBOutlet var contentView: WeekView!
    
    @IBOutlet weak var mondayLabel: UILabel!
    
    @IBOutlet weak var mondayDateLabel: UILabel!
    
    @IBOutlet weak var tuesdayLabel: UILabel!
    
    @IBOutlet weak var tuesdayDateLabel: UILabel!
    
    @IBOutlet weak var wednesdayLabel: UILabel!
    
    @IBOutlet weak var wednesdayDateLabel: UILabel!
    
    @IBOutlet weak var thursdayLabel: UILabel!
    
    @IBOutlet weak var thursdayDateLabel: UILabel!
    
    @IBOutlet weak var fridayLabel: UILabel!
    
    @IBOutlet weak var fridayDateLabel: UILabel!
    
    @IBOutlet weak var saturdayLabel: UILabel!
    
    @IBOutlet weak var saturdayDateLabel: UILabel!
    
    @IBOutlet weak var sundayLabel: UILabel!
    
    @IBOutlet weak var sundayDateLabel: UILabel!
    
    var week = [Date]()
    
    weak var delegate: WeekViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initView()
    }
    
    @IBAction func onChangeDate(_ sender: UIButton) {
        
        switch sender {
            
        case weekButtons[0]:
            print(week[0])
            delegate?.changeDate(date: week[0])
            
        case weekButtons[1]:
            print(week[1])
            delegate?.changeDate(date: week[1])
        
        case weekButtons[2]:
            print(week[2])
            delegate?.changeDate(date: week[2])
            
        case weekButtons[3]:
            print(week[3])
            delegate?.changeDate(date: week[3])

        case weekButtons[4]:
            print(week[4])
            delegate?.changeDate(date: week[4])
            
        case weekButtons[5]:
            print(week[5])
            delegate?.changeDate(date: week[5])
            
        case weekButtons[6]:
            print(week[6])
            delegate?.changeDate(date: week[6])
            
        default:
            break
        }
        
        for button in weekButtons {
            
            button.isSelected = false
        }
        
        sender.isSelected = true
        
        sender.backgroundColor = .G2
        
        sender.alpha = 0.25
        
        guard let date = Week(rawValue: sender.tag) else { return }
        
        updateTableview(type: date)
    }
    
    private func initView() {
        
        Bundle.main.loadNibNamed(
            String(describing: WeekView.self),
            owner: self,
            options: nil)
        
        stickSubView(contentView)
        
        setUpButtons()
        
        setUpDateLabels()
    }
    
    private func setUpButtons() {
        
        for button in weekButtons {
            
            button.cornerRadius = 10
        }
    }
    
    private func setUpDateLabels() {
        
        var calendar = Calendar(identifier: .republicOfChina)
                
        calendar.firstWeekday = 2 // Start on Monday (or 1 for Sunday)
        
        let today = calendar.startOfDay(for: Date())
        
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
    
    private func updateTableview(type: Week) {
        
        
    }
}

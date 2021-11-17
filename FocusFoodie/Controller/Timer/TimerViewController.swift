//
//  PickerViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseFirestoreSwift

enum ButtonStatus {
    
    case notStarted
    
    case start
    
    case pause
}

class TimerViewController: BaseViewController {
    
    @IBOutlet weak var timerTitle: UILabel!
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var controlButton: UIButton! {
        
        didSet {
            
            self.buttonStatus = .notStarted
        }
    }
    
    @IBOutlet weak var toTimerEditButton: UIButton!
    
    @IBOutlet weak var toContentEditButton: UIButton!
    
    @IBOutlet weak var notificationButton: UIButton!
    
    var timer = Timer()
    
    var recipe: [Recipe]?
    
    var seconds = 0
    
    var originalSeconds = 0
    
    var hiddenNote: String?
    
    var buttonStatus: ButtonStatus = ButtonStatus.notStarted {
        
        didSet {
            
            switch buttonStatus {
                
            case .notStarted:
                
                controlButton.setTitle("START", for: .normal)
                
            case .start:
                
                controlButton.setTitle("PAUSE", for: .normal)
                
            case .pause:
                
                controlButton.setTitle("RESUME", for: .normal)
            }
        }
    }
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTimeEditor" {
            
            guard let timeEditVC = segue.destination as? TimerEditViewController else { return }
            
            timeEditVC.timeHandler = { [weak self] time in
                
                guard let strongSelf = self else { return }
                
                strongSelf.seconds = time * 60
                
                strongSelf.originalSeconds = time * 60
                
                let tuple = strongSelf.secondsToHoursMinutesSeconds(seconds: strongSelf.seconds)
                
                strongSelf.countDownLabel.text = String(format: "%02i:%02i:%02i", tuple.0, tuple.1, tuple.2)
                
                timeEditVC.buttonHandler = { [weak self] status in
                    
                    guard let strongSelf = self else { return }

                    strongSelf.buttonStatus = status
                }
            }
        }
        
        if segue.identifier == "toContentEdit" {
            
            guard let contentEditVC = segue.destination as? ContentEditViewController else { return }
            
            contentEditVC.contentHandler = { [weak self] title, note in
                
                guard let strongSelf = self else { return }
                
                strongSelf.timerTitle.text = title
                
                strongSelf.hiddenNote = note
            }
        }
    }
    
    // MARK: - Button Actions -
    
    @IBAction func didTapControlButton(_ sender: UIButton) {
        
//        let record = Record(
//            ownerId: <#T##String#>,
//            recordTitle: <#T##String?#>,
//            recordCategory: <#T##String?#>,
//            recordNote: <#T##String?#>,
//            focusTime: <#T##Int#>,
//            createdTime: <#T##Timestamp#>,
//            favourite: <#T##Bool?#>,
//            recipeId: <#T##String#>)
//        
//        RecordManager.shared.createRecord(record: record)
        
        switch buttonStatus {
            
        case .notStarted:
            
            timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target:self,
                selector: #selector(countDownHelper),
                userInfo: nil,
                repeats: true)
            
            self.buttonStatus = .start
            
            self.doneButton.isEnabled = true
            
        case .start:
            
            timer.invalidate()

            self.buttonStatus = .pause
            
        case .pause:
            
            timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target:self,
                selector: #selector(countDownHelper),
                userInfo: nil,
                repeats: true)
            
            self.buttonStatus = .start
        }
    }
    
    @IBAction func didTapDoneBtn(_ sender: UIButton) {
        
        // 應該歸零 發出聲響
        
        let tuple = secondsToHoursMinutesSeconds(seconds: originalSeconds)
        
        countDownLabel.text = String(format: "%02i:%02i:%02i", tuple.0, tuple.1, tuple.2)
    }
    
    func configure() {
        
        doneButton.isEnabled = false
        
        doneButton.titleLabel?.font = UIFont.regular(size: 35)
        
        doneButton.layer.cornerRadius = doneButton.frame.width / 2
        
        controlButton.titleLabel?.font = UIFont.regular(size: 35)
        
        controlButton.layer.cornerRadius = controlButton.frame.width / 2
        
        countDownLabel.text = "00:00"
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    @objc func countDownHelper() {
        
        seconds -= 1
        
        let calcuHours = seconds / 3600
        
        let calcuMinutes = (seconds / 60) % 60
        
        let calcuSeconds = seconds % 60
        
        let showHours = calcuHours > 9 ? "\(calcuHours)" : "0\(calcuHours)"
        
        let showMinutes = calcuMinutes > 9 ? "\(calcuMinutes)" : "0\(calcuMinutes)"
        
        let showSeconds = calcuSeconds > 9 ? "\(calcuSeconds)" : "0\(calcuSeconds)"
        
        countDownLabel.text = "\(showHours):\(showMinutes):\(showSeconds)"
        
        if seconds <= 0 {
            
            timer.invalidate()
            
            return
        }
    }
}

// MARK: - Notification -

extension TimerViewController {
    
    func setupNotification(time: Int) {
        
        let alarmContent = UNMutableNotificationContent()
        
        alarmContent.title = ""
        
        alarmContent.body = ""
        
        alarmContent.sound = UNNotificationSound.default
        
        let alarmTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(time), repeats: false)
        
        let alarmRequest = UNNotificationRequest(
            identifier: "alarmTrigger",
            content: alarmContent,
            trigger: alarmTrigger)
        
        UNUserNotificationCenter.current().add(alarmRequest, withCompletionHandler: nil)
    }
    
    func removeNotification() {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["alarmTrigger"])
    }
}

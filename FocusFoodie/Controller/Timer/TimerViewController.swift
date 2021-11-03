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

class TimerViewController: BaseViewController {
    
    var seconds = 0
    
    var startStatus = true
    
    var pauseStatus = false
    
    var timer = Timer()
    
    let formatter = DateFormatter()
    
    @IBOutlet weak var cookingImageView: UIImageView! {
        
        didSet {
            
            cookingImageView.image = .asset(.icon_loading)
            
        }
    }
    
    @IBOutlet weak var countDownLabel: UILabel! {
        
        didSet {
            
            countDownLabel.text = "3:00:00"
            
            countDownLabel.textColor = .B5
            
            countDownLabel.font = .medium(size: 40)
        }
    }
    
    @IBOutlet weak var doneButton: UIButton! {
        
        didSet {
            
            doneButton.setTitle("Done", for: .normal)
            
            doneButton.setTitleColor(.white, for: .normal)
                        
            doneButton.backgroundColor = .B6
            
            doneButton.layer.cornerRadius = doneButton.frame.width / 2
        }
    }
    
    @IBOutlet weak var controlButton: UIButton! {
        
        didSet {
            
            controlButton.setTitle("Start", for: .normal)
            
            controlButton.setTitleColor(.white, for: .normal)
            
            controlButton.backgroundColor = .B6
            
            controlButton.layer.cornerRadius = controlButton.frame.width / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDoneButton()
    }
    
    // MARK: - Button Actions -
    
    @IBAction func didTapControlButton(_ sender: UIButton) {
        
//        formatter.dateFormat = "HH"
//
//        let hours = formatter.string(from: countdownTimer.date)
//
//
//        formatter.dateFormat = "mm"
//
//        let minutes = formatter.string(from: countdownTimer.date)
//
//        seconds = Int(hours)! * 60 * 60 + Int(minutes)! * 60
        
//        if startStatus {
//
//            timer = Timer.scheduledTimer(timeInterval: 1.0,
//                                         target:self,
//                                         selector: #selector(countDownHelper),
//                                         userInfo: nil,
//                                         repeats: true)
//
//            setupNotification(time: seconds)
//
//            startStatus = false
//            controlButton.setTitle("Pause", for: .normal)
//
//            pauseStatus = true
//            doneButton.isEnabled = true
//
//
//        } else {
//
//            timer.invalidate()
//            removeNotification()
//
//            startStatus = true
//            startBtn.setTitleColor(.white, for: .normal)
//            startBtn.setTitle("Start", for: .normal)
//
//
//            countdownTimer.isHidden = false
//            timerLabel.isHidden = true
//
//            pauseStatus = false
//            pauseBtn.isEnabled = false
//            pauseBtn.setTitleColor(.lightGray, for: .normal)
//
//        }
    }
    
    @IBAction func didTapDoneBtn(_ sender: UIButton) {
        
    }
    
    func setUpDoneButton() {
        
        doneButton.isEnabled = false
        doneButton.backgroundColor = .B5
        doneButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func countDownHelper() {
        
        seconds -= 1
        
        let countDownHour = seconds / 3600
        
        let countDownMinute = (seconds / 60) % 60
        
        let countDownSecond = seconds % 60
        
        let displayHour = countDownHour > 9 ? "\(countDownHour)" : "0\(countDownHour)"
        
        let displayMinute = countDownMinute > 9 ? "\(countDownMinute)" : "0\(countDownMinute)"
        
        let displaySecond = countDownSecond > 9 ? "\(countDownSecond)" : "0\(countDownSecond)"
        
        countDownLabel.text = "\(displayHour):\(displayMinute):\(displaySecond)"
        
        if seconds <= 0 {
            
            timer.invalidate()
            
            return
        }
    }
    
    
    func setupNotification(time:Int) {
        
        let alarmContent = UNMutableNotificationContent()
        
        alarmContent.title = ""
        
        alarmContent.body = ""
        
        alarmContent.sound = UNNotificationSound.default
        
        let alarmTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(time), repeats: false)
        
        let alarmRequest = UNNotificationRequest(identifier: "alarmTrigger", content: alarmContent, trigger: alarmTrigger)
        
        UNUserNotificationCenter.current().add(alarmRequest, withCompletionHandler: nil)
        
    }
    
    func removeNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["alarmTrigger"])
    }
}

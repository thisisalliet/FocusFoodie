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

protocol ProductPickerControllerDelegate: AnyObject {
    
    func timeChange(_ controller: TimerEditViewController)
}

class TimerViewController: BaseViewController {
    
    @IBOutlet weak var timerTitle: UILabel!
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var doneButton: UIButton! {
        
        didSet {
            
            doneButton.layer.cornerRadius = doneButton.frame.width / 2
        }
    }
    
    @IBOutlet weak var controlButton: UIButton! {
        
        didSet {
            
            controlButton.layer.cornerRadius = controlButton.frame.width / 2
        }
    }
    
    @IBOutlet weak var toEditorButton: UIButton!
    
    @IBOutlet weak var notificationButton: UIButton!
    
    var seconds = 0
    
    var startStatus = true
    
    var pauseStatus = false
    
    let formatter = DateFormatter()
    
    var timeRemaining: Int = 30
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDoneButton()
    }
    
    // MARK: - Button Actions -
    
    @IBAction func didTapControlButton(_ sender: UIButton) {
        
        timer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(step),
            userInfo: nil,
            repeats: true)
        
        //        stopWatch.start()
        
        //        timer = Timer.scheduledTimer(
        //            timeInterval: 1,
        //            target: self,
        //            selector: #selector(step),
        //            userInfo: nil,
        //            repeats: true)
        //
        //        formatter.dateFormat = "HH"
        //
        //        let hours = formatter.string(from: countDownLabel.text)
        //
        //
        //        formatter.dateFormat = "mm"
        //
        //        let minutes = formatter.string(from: countdownTimer.date)
        //
        //        seconds = Int(hours)! * 60 * 60 + Int(minutes)! * 60
        //
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
        
        timer.invalidate()
        
        countDownLabel.text = "\(timeRemaining)"
    }
    
    func setUpDoneButton() {
        
        doneButton.isEnabled = false
        
        doneButton.alpha = 0.75
    }
    
    @objc func step() {
        
        if timeRemaining > 0 {
            
            timeRemaining -= 1
            
        } else {
            
            timer.invalidate()
        }
        
        countDownLabel.text = "\(timeRemaining)"
    }
    
    //    @objc func updateElapsedTimeLabel(_ timer: Timer) {
    //        if stopWatch.isRunning {
    //            countDownLabel.text = stopWatch.elapsedTimeAsString
    //        } else {
    //            timer.invalidate()
    //        }
    //    }
    //
    //    func updateCountDownLabel(_ totalTime: Int) {
    //
    //        seconds -= 1
    //
    //        let countDownHour = seconds / 3600
    //
    //        let countDownMinute = (seconds / 60) % 60
    //
    //        let countDownSecond = seconds % 60
    //
    //        let displayHour = countDownHour > 9 ? "\(countDownHour)" : "0\(countDownHour)"
    //
    //        let displayMinute = countDownMinute > 9 ? "\(countDownMinute)" : "0\(countDownMinute)"
    //
    //        let displaySecond = countDownSecond > 9 ? "\(countDownSecond)" : "0\(countDownSecond)"
    //
    //        countDownLabel.text = "\(displayHour):\(displayMinute):\(displaySecond)"
    //
    //        if seconds <= 0 {
    //
    //            timer.invalidate()
    //
    //            return
    //        }
    //    }
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

extension TimerViewController: TimerEditControllerDelegate {
    
    func dismissEditor(_ controller: TimerEditViewController) {
        
    }
    
    func timeChange(_ controller: TimerEditViewController) {
        
        //        guard controller.selectedIngredient != nil
        //
        //        updateCountDownLabel(<#T##Int#>)
    }
}

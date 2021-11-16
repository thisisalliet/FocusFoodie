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
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var controlButton: UIButton!
    
    @IBOutlet weak var toEditorButton: UIButton!
    
    @IBOutlet weak var notificationButton: UIButton!
    
    var seconds = 0
    
    var startStatus = true
    
    var pauseStatus = false
    
    let formatter = DateFormatter()
        
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Button Actions -
    
    @IBAction func didTapControlButton(_ sender: UIButton) {
        
        formatter.dateFormat = "HH"
        
        let hours = countDownLabel.text
        
        formatter.dateFormat = "mm"
        
        let minutes = countDownLabel.text
        
        seconds = Int(hours ?? "0")! * 60 * 60 + Int(minutes ?? "0")! * 60
        
        if startStatus {
            
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target:self,
                                         selector: #selector(countDownHelper),
                                         userInfo: nil,
                                         repeats: true)
            
            setupNotification(time: seconds)
            
            startStatus = false
            
            controlButton.setTitle("PAUSE", for: .normal)
            
            pauseStatus = true
            
            doneButton.isEnabled = true
            
        } else {
            
            timer.invalidate()
            
            removeNotification()
            
            startStatus = true
                        
            controlButton.setTitle("START", for: .normal)
                        
            pauseStatus = false
            
            doneButton.isEnabled = false
        }
    }
    
    @IBAction func didTapDoneBtn(_ sender: UIButton) {
        
        if pauseStatus{
            
                    timer.invalidate()
            
                    removeNotification()
            
                    pauseStatus = false
            
                    doneButton.setTitle("Resume", for: .normal)
            
                } else {
                    timer = Timer.scheduledTimer(
                        timeInterval: 1.0,
                        target:self,
                        selector: #selector(countDownHelper),
                        userInfo: nil,
                        repeats: true)
                    
                    setupNotification(time: seconds)
                    
                    pauseStatus = true
                    
                    doneButton.setTitle("Pause", for: .normal)
                    
                }
    }
    
    func configure() {
        
        doneButton.isEnabled = false
        
        doneButton.titleLabel?.font = UIFont.regular(size: 35)
        
        doneButton.layer.cornerRadius = doneButton.frame.width / 2
        
        controlButton.titleLabel?.font = UIFont.regular(size: 35)
        
        controlButton.layer.cornerRadius = controlButton.frame.width / 2
        
        countDownLabel.text = "10"
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

extension TimerViewController: TimerEditControllerDelegate {
    
    func dismissEditor(_ controller: TimerEditViewController) {
        
    }
    
    func timeChange(_ controller: TimerEditViewController) {
        
        //        guard controller.selectedIngredient != nil
        //
        //        updateCountDownLabel(<#T##Int#>)
    }
}

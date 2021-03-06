//
//  TimerViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/25.
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

private struct Segue {

    static let contentEditor = "SegueContent"
}

class TimerViewController: BaseViewController {
    
    @IBOutlet weak var timerTitle: UILabel!
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var controlButton: UIButton! {
        
        didSet {
            
            self.buttonStatus = .notStarted
        }
    }
    
    @IBOutlet weak var toTimerEditButton: UIButton!
    
    @IBOutlet weak var toContentEditButton: UIButton!
    
    @IBOutlet weak var notificationButton: UIButton!
    
    var timer = Timer()
    
    var recipe: Recipe?
    
    var seconds = 0
    
    var originalSeconds = 0
    
    var hiddenNote: String?
        
    var hiddenCategory: String?
        
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
        
        if isInitial() {
            
            setButtonsEnabled(false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let identifier = segue.identifier
        
        if identifier == Segue.contentEditor {
            
            guard let contentEditVC = segue.destination as? ContentEditViewController else { return }
            
            contentEditVC.contentHandler = { [weak self] title, note in
                
                guard let strongSelf = self else { return }
                
                strongSelf.timerTitle.text = title
                
                strongSelf.hiddenNote = note
            }
            
            contentEditVC.categoryHandler = { [weak self] title, image in
                
                guard let strongSelf = self else { return }
                
                strongSelf.hiddenCategory = title
                
                strongSelf.timerTitle.text = title
                
                strongSelf.categoryImage.image = image
            }
            
            contentEditVC.timeHandler = { [weak self] time in
                
                guard let strongSelf = self else { return }
                
                strongSelf.seconds = 5

                strongSelf.originalSeconds = time
                
                let tuple = strongSelf.secondsToHoursMinutesSeconds(seconds: strongSelf.seconds)
                
                strongSelf.countDownLabel.text = String(format: "%02i:%02i:%02i", tuple.0, tuple.1, tuple.2)
                
                strongSelf.setButtonsEnabled(true)
            }
            
            contentEditVC.recipeHandler = { [weak self] recipe in
                
                guard let strongSelf = self else { return }
                
                strongSelf.recipe = recipe
            }
        }
    }
    
    // MARK: - Button Action -
    
    @IBAction func didTapControlButton(_ sender: UIButton) {
        
        switch buttonStatus {
            
        case .notStarted:
            
            timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target:self,
                selector: #selector(countDownHelper),
                userInfo: nil,
                repeats: true)
            
            self.buttonStatus = .start
            
            self.resetButton.isEnabled = true
            
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
                
        let tuple = secondsToHoursMinutesSeconds(seconds: originalSeconds)
        
        countDownLabel.text = String(format: "%02i:%02i:%02i", tuple.0, tuple.1, tuple.2)
    }
    
    // MARK: - Private Method -
    
    private func configure() {
        
        resetButton.isEnabled = false
        
        resetButton.titleLabel?.font = UIFont.regular(size: 35)
        
        resetButton.layer.cornerRadius = resetButton.frame.width / 2
        
        controlButton.titleLabel?.font = UIFont.regular(size: 35)
        
        controlButton.layer.cornerRadius = controlButton.frame.width / 2
        
        countDownLabel.text = "00:00:00"
    }
    
    private func isInitial() -> Bool {
        
        return self.originalSeconds == 0
    }
    
    private func setButtonsEnabled(_ enabled: Bool) {
        
        controlButton.isEnabled = enabled
        
        resetButton.isEnabled = enabled
        
        if enabled {
            
            controlButton.backgroundColor = .G3
            
            resetButton.backgroundColor = .G3
            
        } else {
                        
            controlButton.backgroundColor = .lightGray
                        
            resetButton.backgroundColor = .lightGray
        }
    }
    
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        
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
            
            createRecord()
            
            showEndImage()
            
            setupNotification()
        }
    }
    
    private func createRecord() {
        
        let record = Record(
            ownerId: UserManager.shared.currentUserId,
            recordTitle: timerTitle.text,
            recordCategory: hiddenCategory,
            recordNote: hiddenNote,
            focusTime: originalSeconds,
            createdTime: Date().timeIntervalSince1970,
            recipeId: recipe?.recipeId ?? "")
        
        RecordManager.shared.createRecord(record: record)
    }
    
    private func showEndImage() {
        
        guard let endVC = UIStoryboard
                .timer
                .instantiateViewController(
                    withIdentifier: String(describing: EndingViewController.self)
                ) as? EndingViewController else {
                    return }
        
        endVC.modalPresentationStyle = .overFullScreen
        
        endVC.recipe = recipe
        
        present(endVC, animated: true, completion: nil)
    }
}

// MARK: - Notification -

extension TimerViewController {
    
    func setupNotification() {
        
        let alarmContent = UNMutableNotificationContent()
        
        alarmContent.title = "Congratulations!"
        
        alarmContent.body = "You've made a deleicious sandwich."
        
        alarmContent.sound = UNNotificationSound.default
        
//        let alarmTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(1), repeats: false)
        
        let alarmRequest = UNNotificationRequest(
            identifier: "alarmTrigger",
            content: alarmContent,
            trigger: nil)
        
        UNUserNotificationCenter.current().add(alarmRequest, withCompletionHandler: nil)
    }
    
    func removeNotification() {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["alarmTrigger"])
    }
}

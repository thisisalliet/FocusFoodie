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
    
    //NEW
    var timerCounting: Bool = false
    
    var startTime: Date?
    
    var stopTime: Date?
    
    let userDefaults = UserDefaults.standard
    
    let startTimeKey = "startTime"
    
    let stopTimeKey = "stopTime"
    
    let countingKey = "countingKey"
    
    var scheduledTimer: Timer!
    // NEW
    
    var timer = Timer()
    
    var recipe: Recipe?
    
    var breadType: String?
    
    var seconds = 0
    
    var originalSeconds = 0
    
    var recipeIdForEndImage: String?
    
    var hiddenNote: String?
        
    var hiddenCategory: String?
    
    var recipeHandler: ((_ recipe: Recipe) -> Void)?
            
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
        
        // NEW
        startTime = userDefaults.object(forKey: startTimeKey) as? Date

        stopTime = userDefaults.object(forKey: stopTimeKey) as? Date

        timerCounting = userDefaults.bool(forKey: countingKey)
        
        self.tabBarController?.tabBar.isHidden = false
        
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
                
                strongSelf.seconds = time * 60
                
                strongSelf.originalSeconds = time
                
                let tuple = strongSelf.secondsToHoursMinutesSeconds(seconds: strongSelf.seconds)
                
                strongSelf.countDownLabel.text = String(format: "%02i:%02i:%02i", tuple.0, tuple.1, tuple.2)
                
                strongSelf.setButtonsEnabled(true)
            }
        }
    }
    
    // MARK: - Button Actions -
    
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
    
    func configure() {
        
        resetButton.isEnabled = false
        
        resetButton.titleLabel?.font = UIFont.regular(size: 35)
        
        resetButton.layer.cornerRadius = resetButton.frame.width / 2
        
        controlButton.titleLabel?.font = UIFont.regular(size: 35)
        
        controlButton.layer.cornerRadius = controlButton.frame.width / 2
        
        countDownLabel.text = "00:00:00"
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
            
            setupNotification()
            
            let record = Record(
                ownerId: "",
                recordTitle: timerTitle.text,
                recordCategory: hiddenCategory,
                recordNote: hiddenNote,
                focusTime: originalSeconds,
                createdTime: Date().timeIntervalSince1970,
                recipeId: id)
            
            RecordManager.shared.createRecord(record: record) { [weak self] result in
                
                let semaphore = DispatchSemaphore(value: 1)
                                
                switch result {
                    
                case .success(let recipeId):
                    
                    RecipeManager.shared.fetchRecipeInfo(recipeId: recipeId) { result in
                        
                        switch result {
                            
                        case .success(let recipeInfo):
                            
                            guard let recipeHandler = self?.recipeHandler else { return }
                            
                            recipeHandler(recipeInfo)
                            
                            self?.recipe = recipeInfo
                            
                            self?.breadType = recipeInfo.bread
                            
                            semaphore.signal()

                        case .failure(let error):
                            
                            print(error)
                            
                            semaphore.signal()
                        }
                    }
                    
                case .failure(let error):
                    
                    print(error)
                    
                    semaphore.signal()
                }
                
            }
            
            guard let endVC = UIStoryboard
                    .timer
                    .instantiateViewController(
                        withIdentifier: String(describing: EndingViewController.self)
                    ) as? EndingViewController else {
                        return
                    }
            
            guard let breadType = breadType else { return }
            
            endVC.updateContainer(type: EndingViewController.BreadType(rawValue: breadType) ?? .toast)
            
            endVC.vegetableItem = recipe?.vegetable ?? "Lettuce"
            
            endVC.meatItem = recipe?.meat ?? "Bacon"
            
            endVC.sideItem = recipe?.side ?? "Egg"
                        
            endVC.modalPresentationStyle = .overFullScreen
            
            present(endVC, animated: true, completion: nil)
            
            return
        }
    }
    
    func isInitial() -> Bool {
        
        return self.originalSeconds == 0
    }
    
    func setButtonsEnabled(_ enabled: Bool) {
        
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

//extension TimerViewController: TimerEditDelegate {
//
//    func passTime(minutes: Int) {
//
//        self.seconds = minutes * 60
//
//        self.originalSeconds = minutes * 60
//
//        let tuple = self.secondsToHoursMinutesSeconds(seconds: self.seconds)
//
//        countDownLabel.text = String(format: "%02i:%02i:%02i", tuple.0, tuple.1, tuple.2)
//    }
//}

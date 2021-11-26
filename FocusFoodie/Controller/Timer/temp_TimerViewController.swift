////
////  PickerViewController.swift
////  FocusFoodie
////
////  Created by Allie T on 2021/10/20.
////
//
//import UIKit
//import UserNotifications
//import Firebase
//import FirebaseFirestoreSwift
//
//enum ButtonStatus {
//
//    case notStarted
//
//    case startOrResume
////    (endTime: Date)
//    // buttonTitle pause
//    // 存 endTime
//    // endTime - remainingTime <= 0 -> finish
//    // endTime - remainingTime > 0 -> unfinish
//
//    case pause
////    (remainingTime: Int)
//    // buttonTitle resume
//    // 存 remainingTime
//
//}
//
////enum ButtonStatus: Int {
////
////    case initial
//    // buttonTitle start
//
////    case isRunning
////    (endTime: Date)
//    // buttonTitle pause
//    // 存 endTime
//    // endTime - remainingTime <= 0 -> finish
//    // endTime - remainingTime > 0 -> unfinish
//
////    case paused
////    (remainingTime: Int)
//    // buttonTitle resume
//    // 存 remainingTime
//
////}
//
////let ststus = ButtonStatus(rawValue: <#T##Int#>)
//
//class temp_TimerViewController: BaseViewController {
//
//    @IBOutlet weak var timerTitle: UILabel!
//
//    @IBOutlet weak var countDownLabel: UILabel!
//
//    @IBOutlet weak var categoryImage: UIImageView!
//
//    @IBOutlet weak var resetButton: UIButton!
//
//    @IBOutlet weak var controlButton: UIButton!
//
//    @IBOutlet weak var toTimerEditButton: UIButton!
//
//    @IBOutlet weak var toContentEditButton: UIButton!
//
//    @IBOutlet weak var notificationButton: UIButton!
//
//    // NEW
//    var timerCounting: Bool = false
//
//    var startTime: Date?
//
//    var stopTime: Date?
//
//    var resumeTime: Date?
//
//    var endTime: Date?
//
//    let userDefaults = UserDefaults.standard
//
//    let startTimeKey = "startTime"
//
//    let stopTimeKey = "stopTime"
//
//    let endTimeKey = "endTime"
//
//    let resumeTimeKey = "resumeKey"
//
//    let countingKey = "countingKey"
//
//    var scheduledTimer: Timer!
//    // NEW
//
////    var timer = Timer()
//
//    var recipe: [Recipe]?
//
//    var seconds = 0
//
//    var originalSeconds = 0
//
//    var hiddenNote: String?
//
//    var hiddenCategory: String?
//
//    var buttonStatus: ButtonStatus = ButtonStatus.notStarted {
//
//        didSet {
//
//            switch buttonStatus {
//
//            case .notStarted:
//
//                resetButton.isEnabled = false
//
//                controlButton.setTitle("START", for: .normal)
//
//            case .startOrResume:
//
//                resetButton.isEnabled = true
//
//                controlButton.setTitle("PAUSE", for: .normal)
//
//            case .pause:
//
//                resetButton.isEnabled = true
//
//                controlButton.setTitle("RESUME", for: .normal)
//
//            }
//        }
//    }
//
//    let formatter = DateFormatter()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configure()
//
//        // NEW
//        startTime = userDefaults.object(forKey: startTimeKey) as? Date
//
//        stopTime = userDefaults.object(forKey: stopTimeKey) as? Date
//
//        resumeTime = userDefaults.object(forKey: resumeTimeKey) as? Date
//
//        endTime = userDefaults.object(forKey: endTimeKey) as? Date
//
//        timerCounting = userDefaults.bool(forKey: countingKey)
//
//        if let resume = resumeTime {
//
//            if let end = endTime {
//
//                let time = calcuRemainingTime(resume: resume, end: end)
//
//                let diff = Date().timeIntervalSince(time)
//
//                setCountDownLabel(time: Int(diff))
//            }
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toTimeEditor" {
//
//            guard let timeEditVC = segue.destination as? TimerEditViewController else { return }
//
//            timeEditVC.timeHandler = { [weak self] time in
//
//                guard let strongSelf = self else { return }
//
//                strongSelf.seconds = time * 60
//
//                strongSelf.originalSeconds = time * 60
//
//                let tuple = strongSelf.secondsToHoursMinutesSeconds(seconds: strongSelf.seconds)
//
//                strongSelf.countDownLabel.text = String(format: "%02i:%02i:%02i", tuple.0, tuple.1, tuple.2)
//
//                timeEditVC.buttonHandler = { [weak self] status in
//
//                    guard let strongSelf = self else { return }
//
//                    //                    strongSelf.buttonStatus = status
//                }
//            }
//        }
//
//        if segue.identifier == "toContentEdit" {
//
//            guard let contentEditVC = segue.destination as? ContentEditViewController else { return }
//
//            contentEditVC.contentHandler = { [weak self] title, note in
//
//                guard let strongSelf = self else { return }
//
//                strongSelf.timerTitle.text = title
//
//                strongSelf.hiddenNote = note
//            }
//
//            contentEditVC.categoryHandler = { [weak self] title, image in
//
//                guard let strongSelf = self else { return }
//
//                strongSelf.hiddenCategory = title
//
//                strongSelf.categoryImage.image = image
//            }
//        }
//    }
//
//    // MARK: - Button Actions -
//
//    @IBAction func didTapControlButton(_ sender: UIButton) {
//
////        if timerCounting {
////
////            startTimer()
////
////            setEndTime(time: Date())
////
////        } else {
////
////            pauseTimer()
////        }
////
////        if let end = endTime {
////
////            let remainTime = calcuRemainingTime(resume: resumeTime ?? Date(), end: end)
////
////            setResumeTime(time: remainTime)
////
////            startTimer()
////    }
//        switch buttonStatus {
//
//        case .notStarted:
//
//            scheduledTimer = Timer.scheduledTimer(
//                timeInterval: 1.0,
//                target:self,
//                selector: #selector(countDownHelper),
//                userInfo: nil,
//                repeats: true)
//
//            self.buttonStatus = .startOrResume
//
//        case .startOrResume:
//
//            pauseTimer()
//
//            //                            timer.invalidate()
//
//            self.buttonStatus = .pause
//
//        case .pause:
//
//            startTimer()
//
////            timer = Timer.scheduledTimer(
////                timeInterval: 1.0,
////                target:self,
////                selector: #selector(countDownHelper),
////                userInfo: nil,
////                repeats: true)
//
//            self.buttonStatus = .startOrResume
//        }
//
////                if timerCounting {
////
////                    pauseTimer()
////
////                } else {
////
////                    if let end = endTime {
////
////                        let remainTime = calcuRemainingTime(resume: resumeTime ?? Date(), end: end)
////
////                        setResumeTime(time: remainTime)
////
////                    } else {
////
////                        setResumeTime(time: Date())
////                    }
////                }
////                if timerCounting {
////
////                    setStopTime(time: Date())
////
////                    stopTimer()
////
////                } else {
////
////                    if let stop = stopTime {
////
////                        let restartTime = calcuRestartTime(start: startTime ?? Date(), stop: stop)
////
////                        setStopTime(time: nil)
////
////                        setStartTime(time: restartTime)
////
////                    } else {
////
////                        setStartTime(time: Date())
////                    }
////
////                    startTimer()
////                }
//            }
//
//
//    @IBAction func didTapResetButton(_ sender: UIButton) {
//
//        let tuple = secondsToHoursMinutesSeconds(seconds: originalSeconds)
//
//        countDownLabel.text = String(format: "%02i:%02i:%02i", tuple.0, tuple.1, tuple.2)
//    }
//
//    func configure() {
//
//        resetButton.isEnabled = false
//
//        resetButton.titleLabel?.font = UIFont.regular(size: 35)
//
//        resetButton.layer.cornerRadius = resetButton.frame.width / 2
//
//        controlButton.titleLabel?.font = UIFont.regular(size: 35)
//
//        controlButton.layer.cornerRadius = controlButton.frame.width / 2
//
//        countDownLabel.text = "00:00"
//    }
//
//    // NEW
//    func setCountDownLabel(time: Int) {
//
//        let time = secondsToHoursMinutesSeconds(seconds: time)
//
//        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
//
//        countDownLabel.text = timeString
//    }
//
//    func calcuRemainingTime(resume: Date, end: Date) -> Date {
//
//        let diff = resume.timeIntervalSince(end)
//
//        return Date().addingTimeInterval(diff)
//    }
//
//    func startTimer() {
//
//        scheduledTimer = Timer.scheduledTimer(
//            timeInterval: 1,
//            target: self,
//            selector: #selector(countDownHelper),
//            userInfo: nil,
//            repeats: true)
//
//        setTimerCounting(status: true)
//
//        controlButton.setTitle("PAUSE", for: .normal)
//    }
//
//    func pauseTimer() {
//
//        if scheduledTimer != nil {
//
//            scheduledTimer.invalidate()
//        }
//
//        setTimerCounting(status: false)
//
//        controlButton.setTitle("RESUME", for: .normal)
//    }
//
//    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
//
//        let hour = seconds / 3600
//
//        let min = (seconds % 3600) / 60
//
//        let sec = (seconds % 3600) % 60
//
//        return (hour, min, sec)
//    }
//
//    func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
//
//        var timeString = ""
//
//        timeString += String(format: "%02d", hour)
//
//        timeString += ":"
//
//        timeString += String(format: "%02d", min)
//
//        timeString += ":"
//
//        timeString += String(format: "%02d", sec)
//
//        return timeString
//    }
//
//    func setStartTime(time: Date?) {
//
//        startTime = time
//
//        userDefaults.set(startTime, forKey: startTimeKey)
//    }
//
//    func setStopTime(time: Date?) {
//
//        stopTime = time
//
//        userDefaults.set(stopTime, forKey: stopTimeKey)
//    }
//
//    func setResumeTime(time: Date?) {
//
//        resumeTime = time
//
//        userDefaults.set(resumeTime, forKey: resumeTimeKey)
//    }
//
//    func setEndTime(time: Date?) {
//
//        endTime = time
//
//        userDefaults.set(endTime, forKey: endTimeKey)
//    }
//
//    func setTimerCounting(status: Bool) {
//
//        timerCounting = status
//
//        userDefaults.set(timerCounting, forKey: countingKey)
//    }
//    // NEW
//
//    @objc func countDownHelper() {
//
//        seconds -= 1
////
////        if let end = endTime {
////
////            let diff = Date().timeIntervalSince(end)
////
////            let calcuHours = Int(diff) / 3600
////
////            let calcuMinutes = (Int(diff) / 60) % 60
////
////            let calcuSeconds = Int(diff) % 60
////
////            let showHours = calcuHours > 9 ? "\(calcuHours)" : "0\(calcuHours)"
////
////            let showMinutes = calcuMinutes > 9 ? "\(calcuMinutes)" : "0\(calcuMinutes)"
////
////            let showSeconds = calcuSeconds > 9 ? "\(calcuSeconds)" : "0\(calcuSeconds)"
////
//////            countDownLabel.text = "\(showHours):\(showMinutes):\(showSeconds)"
////            countDownLabel.text = "\("hi"):\("allie"):\(seconds)"
////
////            //            setCountDownLabel(time: Int(diff))
////
////        } else {
////
////            pauseTimer()
////
////            setCountDownLabel(time: 0)
////        }
////
//                let calcuHours = seconds / 3600
//
//                let calcuMinutes = (seconds / 60) % 60
//
//                let calcuSeconds = seconds % 60
//
//                let showHours = calcuHours > 9 ? "\(calcuHours)" : "0\(calcuHours)"
//
//                let showMinutes = calcuMinutes > 9 ? "\(calcuMinutes)" : "0\(calcuMinutes)"
//
//                let showSeconds = calcuSeconds > 9 ? "\(calcuSeconds)" : "0\(calcuSeconds)"
//
//                countDownLabel.text = "\(showHours):\(showMinutes):\(showSeconds)"
//
//        if seconds <= 0 {
//
//            guard let endVC = UIStoryboard
//                    .timer
//                    .instantiateViewController(
//                        withIdentifier: String(describing: EndingViewController.self)
//                    ) as? EndingViewController else { return }
//
//            setupNotification()
//
//            endVC.modalPresentationStyle = .overFullScreen
//
//            present(endVC, animated: true, completion: nil)
//
////            timer.invalidate()
//
//            let record = Record(
//                ownerId: "",
//                recordTitle: timerTitle.text,
//                recordCategory: hiddenCategory,
//                recordNote: hiddenNote,
//                focusTime: originalSeconds,
//                createdTime: Date().timeIntervalSince1970,
//                recipeId: "")
//
//            RecordManager.shared.createRecord(record: record)
//
//            return
//        }
//    }
//
//
//    @objc func refreshValue() {
//
//        if let end = endTime {
//
//            let diff = Date().timeIntervalSince(end)
//
//            setCountDownLabel(time: Int(diff))
//
//        } else {
//
//            pauseTimer()
//
//            setCountDownLabel(time: 0)
//        }
//
//        //        if let start = startTime {
//        //
//        //            let diff = Date().timeIntervalSince(start)
//        //
//        //            setCountDownLabel(time: Int(diff))
//        //
//        //        } else {
//        //
//        //            stopTimer()
//        //
//        //            setCountDownLabel(time: 0)
//        //        }
//    }
//}
//
//// MARK: - Notification -
//
//extension temp_TimerViewController {
//
//    func setupNotification() {
//
//        let alarmContent = UNMutableNotificationContent()
//
//        alarmContent.title = "Congratulations!"
//
//        alarmContent.body = "You've made a deleicious sandwich."
//
//        alarmContent.sound = UNNotificationSound.default
//
//        //        let alarmTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(1), repeats: false)
//
//        let alarmRequest = UNNotificationRequest(
//            identifier: "alarmTrigger",
//            content: alarmContent,
//            trigger: nil)
//
//        UNUserNotificationCenter.current().add(alarmRequest, withCompletionHandler: nil)
//    }
//
//    func removeNotification() {
//
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["alarmTrigger"])
//    }
//}

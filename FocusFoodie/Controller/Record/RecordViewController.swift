//
//  RecordViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Lottie

class RecordViewController: BaseViewController,
                            UITableViewDataSource,
                            UITableViewDelegate {
    
    @IBOutlet weak var weekDayLabel: UILabel!
    
    @IBOutlet weak var dateButton: UIButton! {
        
        didSet {
            
            dateButton.alpha = 0.75
            
            dateButton.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var weekView: WeekView! {
        
        didSet {
            
            weekView.delegate = self
        }
    }
    
    @IBOutlet weak var recordTableView: UITableView! {
        
        didSet {
            
            recordTableView.separatorStyle = .none
            
            recordTableView.dataSource = self
            
            recordTableView.delegate = self
        }
    }
    
    @IBOutlet weak var recordLottieView: AnimationView! {
        
        didSet {
            
            recordLottieView.contentMode = .scaleAspectFit
            
            recordLottieView.loopMode = .loop
            
            recordLottieView.animationSpeed = 0.5
        }
    }
    
    @IBOutlet weak var emptyLabel: UILabel!
    
    var db: Firestore!
    
    // FAKE DATA
    var temoCategoryImage = ["icon_fitness", "icon_school"]
    
    var tempTimerImage = ["icon_falafel_wrap", "icon_cheese_burger"]
    
    var tempFocusTime = ["60 MIN", "60 MIN"]
    
    var tempTitle = ["Yoga", "AppWorks School"]
    
    var tempCategoryImage = ["icon_fitness", "icon_school"]
    // FAKE DATA
    
    private var myRecords: [Record] = []
    {
        
        didSet {
            
            checkEmpty()
        }
    }
    
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDate()
        
        setUpTableView()
        
        recordLottieView.isHidden = true
        
        emptyLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.selectedDate = Date()
        
        fetchRecord(date: self.selectedDate)
    }
    
    private func setUpDate() {
        
        let month = Date().monthOfDate()
        
        let date = Date().dateOfWeek()
        
        weekDayLabel.text = Date().dayOfWeek()
        
        dateButton.setTitle("  \(month) \(date)  ", for: .normal)
    }
    
    private func setUpTableView() {
        
        recordTableView.registerCellWithNib(
            identifier: String(describing: RecordCell.self),
            bundle: nil
        )
    }
    
    private func checkEmpty() {
        
        if myRecords.isEmpty {
            
            recordLottieView.isHidden = false
            
            emptyLabel.isHidden = false
            
            if let recordLottieView = recordLottieView {
                
                recordLottieView.play()
                
            } else {
                
                recordLottieView.isHidden = true
                
                emptyLabel.isHidden = true
                
                if let recordLottieView = recordLottieView {
                    
                    recordLottieView.stop()
                }
            }
        }
    }
    
    func fetchRecord(date: Date) {
        
        RecordManager.shared.fetchRecord(date: selectedDate) { result in
            
            switch result {
                
            case .success(let record):
                
                self.myRecords = record
                
                self.recordTableView.performBatchUpdates {
                    
                    let indexSet = IndexSet(integersIn: 0...0)
                    
                    self.recordTableView.reloadSections(indexSet, with: .fade)
                }
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func checkCategory(image: UIImage) {
        
    }
    
    // MARK: - UITableViewDataSource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = recordTableView.dequeueReusableCell(
            withIdentifier: String(describing: RecordCell.self),
            for: indexPath
        )
        
        guard let recordCell = cell as? RecordCell else { return cell }
        
        let record = myRecords[indexPath.row]
        
        //        recordCell.timerImageForRecord.image = UIImage(named: tempTimerImage[indexPath.row])
        //
        //        recordCell.timeLabelForRecord.text = tempFocusTime[indexPath.row]
        //
        //        recordCell.titleLabelForRecord.text = tempTitle[indexPath.row]
        //
        //        recordCell.categoryImageForRecord.image = UIImage(named: tempCategoryImage[indexPath.row])
        
        recordCell.layoutCell(
            timerImage: UIImage.asset(.icon_coding),
            time: record.focusTime,
            title: record.recordTitle ?? "",
            categoryImage: UIImage.asset(.icon_coding))
        
        return recordCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let detailVC = UIStoryboard
                .record
                .instantiateViewController(
                    withIdentifier: String(describing: DetailViewController.self)
                ) as? DetailViewController else {
                    
                    return
                }
        
        detailVC.record = myRecords[indexPath.row]
        
        show(detailVC, sender: nil)
    }
    
    //    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //
    //        let declineAction = UIContextualAction(style: .destructive, title: "") {
    //            (action, sourceView, complete) in
    //
    //            self.myRecords.remove(at: indexPath.row)
    //
    //            self.recordTableView.deleteRows(at: [indexPath], with: .top)
    //
    //            complete(true)
    //        }
    //
    //        declineAction.backgroundColor = .G1
    //
    //        declineAction.image = UIGraphicsImageRenderer(
    //            size: CGSize(width: 40.0, height: 40.0)).image(
    //            actions: { _ in UIImage.asset(.icon_delete)?.draw(
    //                in: CGRect(x: 0, y: 0, width: 40, height: 40))
    //            })
    //
    //        let trailingSwipConfiguration = UISwipeActionsConfiguration(actions: [declineAction])
    //
    //        return trailingSwipConfiguration
    //    }
    
    // MARK: - UITableViewDelegate -
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

extension RecordViewController: WeekViewDelegate {
    
    func changeDate(date: Date) {
        
        fetchRecord(date: date)
    }
}

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
            
            recordTableView.dataSource = self
            
            recordTableView.delegate = self
        }
    }
    
    @IBOutlet weak var recordLottieView: UIView!
    
    @IBOutlet weak var emptyLabel: UILabel!
    
    var db: Firestore!
    
    private var myRecords: [Record]? {
        
        didSet {
            
            checkEmpty()
        }
    }
    
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDate()
        
        setUpTableView()
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
        
        recordTableView.registerCellWithNib(identifier:
                                                String(describing: RecordCell.self),
                                            bundle: nil
        )
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
    
    private func checkEmpty() {
        
        if let myRecords = myRecords {
            
            if myRecords.count <= 0 {
                
                recordLottieView.isHidden = false
                
                emptyLabel.isHidden = false
                
                //                if let emptyAnimation = emptyAnimation {
                //                    emptyAnimation.play()
                
            } else {
                
                recordLottieView.isHidden = true
                
                emptyLabel.isHidden = true
                
                //                    if let emptyAnimation = emptyAnimation {
                //                        emptyAnimation.stop()
                //                    }
            }
            
        } else {
            
            recordLottieView.isHidden = false
            
            emptyLabel.isHidden = false
            
            //                if let emptyAnimation = emptyAnimation {
            //                    emptyAnimation.play()
            //                }
        }
    }
    
    func checkCategory(image: UIImage) {
        
        
    }
    
    // MARK: - UITableViewDataSource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let records = myRecords {
            
            return records.count
            
        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = recordTableView.dequeueReusableCell(
            withIdentifier: String(describing: RecordCell.self),
            for: indexPath
        )
        
        guard let recordCell = cell as? RecordCell,
              let records = myRecords else { return cell }
        
        let record = records[indexPath.row]
        
        recordCell.layoutCell(
            timerImage: UIImage(),
            time: record.focusTime,
            title: record.recordTitle ?? "",
            categoryImage: UIImage())
        
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
        
        
        
        //        detailVC.product = datas[indexPath.section].products[indexPath.row]
        
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

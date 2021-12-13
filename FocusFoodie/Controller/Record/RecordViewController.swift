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
    
    private var myRecords: [Record] = [] {
        
        didSet {
            
            checkEmpty()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDate()
        
        setUpTableView()
        
        recordLottieView.isHidden = true
        
        emptyLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        fetchRecord(date: Date())
    }
    
    // MARK: - Private Method -
    
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
                
            }
            
        } else {
            
            recordLottieView.isHidden = true
            
            emptyLabel.isHidden = true
            
            if let recordLottieView = recordLottieView {
                
                recordLottieView.stop()
            }
        }
    }
    
    // MARK: - Public Method -
    
    func fetchRecord(date: Date) {
        
        RecordManager.shared.fetchRecord(date: date) { result in
            
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
    
    // MARK: - UITableView DataSource -
    
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
        
        let categoryIcon = Category(rawValue: record.recordCategory?.lowercased() ?? "")?.image
        
        recordCell.layoutCell(
            timerImage: categoryIcon,
            time: record.focusTime,
            title: record.recordTitle ?? "",
            categoryImage: categoryIcon)
        
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
    
    // MARK: - UITableView Delegate -
    
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

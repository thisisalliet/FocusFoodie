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
    
    var db: Firestore!
        
    @IBOutlet weak var weekLabel: UILabel!
    
    @IBOutlet weak var dateButton: UIButton! {
        
        didSet {
            
            dateButton.alpha = 0.75
            
            dateButton.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var weekView: WeekView!
    
    @IBOutlet weak var recordTableView: UITableView! {
        
        didSet {
            
            recordTableView.dataSource = self
            
            recordTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDate()
        
        setUpTableView()
    }
    
    private func setUpDate() {
        
        let month = Date().monthOfDate()
        
        let date = Date().currentDate()
        
        weekLabel.text = Date().dayOfWeek()
        
        dateButton.setTitle(" \(month) \(date) ", for: .normal)
    }
    
    private func setUpTableView() {
        
        recordTableView.registerCellWithNib(identifier:
            String(describing: RecordCell.self),
                                            bundle: nil
        )
    }
    
    // MARK: - UITableViewDataSource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = recordTableView.dequeueReusableCell(
            withIdentifier: String(describing: RecordCell.self),
            for: indexPath
        )
        
        guard let cell = cell as? RecordCell else { return cell }
//
//        RecordManager.shared.fetchRecord { result in
//
//            switch result {
//
//            case .success(let myRecord):
//
//
//            case .failure(let error):
//                
//                print(error)
//            }
//        }
        
        return cell
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
    
    // MARK: - UITableViewDelegate -

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

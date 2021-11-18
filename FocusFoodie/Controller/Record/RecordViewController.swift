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
    
    var db: Firestore!
    
    var myRecords: [Record]?
    
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

        RecordManager.shared.fetchRecord { result in

            switch result {
                
            case .success(let myRecords):
                
                self.myRecords = myRecords
                
            case .failure(let error):
                
                print(error)
            }
        }
        
        let cell = recordTableView.dequeueReusableCell(
            withIdentifier: String(describing: RecordCell.self),
            for: indexPath
        )
        
        guard let recordCell = cell as? RecordCell else { return cell }
        
        let item = myRecords?[indexPath.row]
        
//        recordCell.layoutCell(
//            timerImage: UIImage() ,
//            time: item!.focusTime,
//            title: (item?.recordTitle)!,
//            categoryImage: UIImage())
        
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

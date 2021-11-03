//
//  DetailViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class DetailViewController: BaseViewController,
                             UITableViewDataSource,
                             UITableViewDelegate {
    
    var db: Firestore!
    
    var record = [Record]() {
        
        didSet {
            
            detailTableView.reloadData()
        }
    }
    
    @IBOutlet weak var detailTableView: UITableView! {
        
        didSet {
            
            detailTableView.separatorStyle = .none
            
            detailTableView.dataSource = self
            
            detailTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        setUpTableView()
    }
    
    private func setUpTableView() {
        
        detailTableView.registerCellWithNib(identifier:
            String(describing: DetailImageTableViewCell.self),
                                            bundle: nil
        )
        
        detailTableView.registerCellWithNib(identifier:
            String(describing: DetailInfoTableViewCell.self),
                                            bundle: nil
        )
        
        detailTableView.registerCellWithNib(identifier:
            String(describing: DetailNoteTableViewCell.self),
                                            bundle: nil
        )
    }
    
    // MARK: - UITableViewDataSource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
//        return record.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            guard let imageCell = detailTableView.dequeueReusableCell(
                withIdentifier: String(describing: DetailImageTableViewCell.self),
                for: indexPath
            ) as? DetailImageTableViewCell else {fatalError("Couldn't generate imageCell")}
            
            return imageCell
            
        case 1:
            guard let infoCell = detailTableView.dequeueReusableCell(
                withIdentifier: String(describing: DetailInfoTableViewCell.self),
                for: indexPath
            ) as? DetailInfoTableViewCell else {fatalError("Couldn't generate infoCell")}
            
//            infoCell.dateLabel.text = Timestamp.timeFormat(time: record[indexPath.row].createdTime)
//
//            infoCell.timeLabel.text = Timestamp.timeFormat(time: record[indexPath.row].createdTime)
            
//            infoCell.focusTimeLabel.text = String(describing: record[indexPath.row].focusTime)
                                    
            return infoCell
            
        case 2:
            
            guard let noteCell = detailTableView.dequeueReusableCell(
                withIdentifier: String(describing: DetailNoteTableViewCell.self),
                for: indexPath
            ) as? DetailNoteTableViewCell else {fatalError("Couldn't generate noteCell")}
            
//            noteCell.categoryTitleLabel.text = record[indexPath.row].recordCategory
            
//            noteCell.noteLabel.text = record[indexPath.row].recordNote
            
            return noteCell
            
        default:
            return DetailImageTableViewCell()
        }
    }
    
    // MARK: - UITableViewDelegate -
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

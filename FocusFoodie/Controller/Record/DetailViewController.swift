//
//  DetailViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class DetailViewController: BaseViewController,
                             UITableViewDataSource,
                             UITableViewDelegate {
    
    @IBOutlet weak var detailTableView: UITableView! {
        
        didSet {
            
            detailTableView.separatorStyle = .none
            
            detailTableView.showsVerticalScrollIndicator = false
            
            detailTableView.dataSource = self
            
            detailTableView.delegate = self
        }
    }
    
    var db: Firestore!
    
    var record: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        navigationController?.setupBackButton(color: .G3 ?? UIColor())
        
        setUpTableView()
    }
    
    // MARK: - Private Method  -
    
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
    
    // MARK: - UITableView DataSource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let record = record else { return DetailImageTableViewCell() }
        
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
            
            let recordTime = Date(timeIntervalSince1970: record.createdTime)
            
            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "MMMM dd HH:mm"
                        
            infoCell.dateLabel.text = dateFormatter.string(from: recordTime)
            
            infoCell.focusTimeLabel.text = "\(record.focusTime)"
                                    
            return infoCell
            
        case 2:
            
            let cell = detailTableView.dequeueReusableCell(
                withIdentifier: String(describing: DetailNoteTableViewCell.self),
                for: indexPath
            )
                
            guard let noteCell = cell as? DetailNoteTableViewCell else { return cell }
            
            noteCell.categoryButton.setTitle(record.recordCategory, for: .normal)
                                
            noteCell.titleTextfield.text = record.recordTitle

            noteCell.noteTextfield.text = record.recordNote
            
            return noteCell
            
        default:
            return DetailImageTableViewCell()
        }
    }
    
    // MARK: - UITableView Delegate -
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0: return 300
            
        case 1: return 120
            
        case 2: return 450
            
        default:
            break
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
}

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
    
    var db: Firestore!
    
    var record = [Record]() {
        
        didSet {
            
            detailTableView.reloadData()
        }
    }
    
    // FAKE DATA
    var tempImage = ["icon_falafel_wrap", "icon_cheese_burger"]
        
    var tempCreatedTime = ["07:00-07:15", "02:00-03:00"]
    
    var tempCreatedDate = ["NOVEMBER 23","NOVEMBER 23"]
    
    var tempFocusTime = [ "60", "60"]
    
    var tempCategory = ["", "", "  Ftiness  ", "  School  "]
    
    var tempCategoryImage = ["", "", "icon_fitness", "icon_school"]
    
    var tempTitle = ["", "", "Yoga", "AppWorks School"]
    
    var tempNote = ["", "", "back stress release and meditation", "final testing of personal project"]
    // FAKE DATA
    
    @IBOutlet weak var detailTableView: UITableView! {
        
        didSet {
            
            detailTableView.separatorStyle = .none
            
            detailTableView.showsVerticalScrollIndicator = false
            
            detailTableView.dataSource = self
            
            detailTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        navigationController?.setupBackButton(color: .G3!)
        
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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            guard let imageCell = detailTableView.dequeueReusableCell(
                withIdentifier: String(describing: DetailImageTableViewCell.self),
                for: indexPath
            ) as? DetailImageTableViewCell else {fatalError("Couldn't generate imageCell")}
            
            imageCell.endImageView.image = UIImage(named: tempImage[indexPath.row])
            
            return imageCell
            
        case 1:
            guard let infoCell = detailTableView.dequeueReusableCell(
                withIdentifier: String(describing: DetailInfoTableViewCell.self),
                for: indexPath
            ) as? DetailInfoTableViewCell else {fatalError("Couldn't generate infoCell")}
            
            infoCell.dateLabel.text = tempCreatedDate[indexPath.row]
//            Timestamp.timeFormat(time: record[indexPath.row].createdTime)

            infoCell.timeLabel.text = tempCreatedTime[indexPath.row]
//            Timestamp.timeFormat(time: record[indexPath.row].createdTime)
            
            infoCell.focusTimeLabel.text = tempFocusTime[indexPath.row]
//            String(describing: record[indexPath.row].focusTime)
                                    
            return infoCell
            
        case 2:
            
            let cell = detailTableView.dequeueReusableCell(
                withIdentifier: String(describing: DetailNoteTableViewCell.self),
                for: indexPath
            )
                
            guard let noteCell = cell as? DetailNoteTableViewCell else { return cell }
            
            noteCell.categoryButton.setTitle("\(tempCategory[indexPath.row])", for: .normal)
            
            noteCell.categoryImage.image = UIImage(named: tempCategoryImage[indexPath.row])
                    
            noteCell.titleTextfield.text = tempTitle[indexPath.row]

            noteCell.noteTextfield.text = tempNote[indexPath.row]
            
//            layoutNoteCell(
//                image: UIImage(named: tempCategoryImage[indexPath.row]) ?? UIImage(),
//                category: tempCategory[indexPath.row],
//                title: tempTitle[indexPath.row],
//                note: tempNote[indexPath.row])
            
//            noteCell.categoryTitleLabel.text = record[indexPath.row].recordCategory
//
//            noteCell.noteLabel.text = record[indexPath.row].recordNote
            
            return noteCell
            
        default:
            return DetailImageTableViewCell()
        }
    }
    
    // MARK: - UITableViewDelegate -
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0: return 300
            
        case 1: return 150
            
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

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
    
    private struct Segue {

        static let picker = "SeguePicker"
    }
    
    var db: Firestore!
    
    @IBOutlet weak var recordTableView: UITableView! {
        
        didSet {
            
            recordTableView.dataSource = self
            
            recordTableView.delegate = self
        }
    }
    
    @IBOutlet weak var profileButton: UIButton! {
        
        didSet {
            
            profileButton.alpha = 10
        }
    }
    
    @IBOutlet weak var calendarPickerView: UIView! {
        
        didSet {
            
            calendarPickerView.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var calendarButton: UIButton! {
        
        didSet {
            
            calendarButton.backgroundColor = .G1
            
            calendarButton.setTitleColor(.G3, for: .normal)
            
            calendarButton.setTitleColor(.G3, for: .selected)
            
            calendarButton.setTitle("Today ▾ ", for: .normal)
            
            calendarButton.cornerRadius = 10
            
        }
    }
    
    @IBOutlet weak var baseView: UIView!
    
    var pickerViewController: CalendarPickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    private func setUpTableView() {
        
        recordTableView.registerCellWithNib(identifier:
            String(describing: RecordCell.self),
                                            bundle: nil
        )
    }
    
    // MARK: - Action
    @IBAction func didTouchCalendarBtn(_ sender: UIButton) {
        
            showCalendarPickerView()
    }
    
    func showCalendarPickerView() {

        let maxY = recordTableView.frame.maxY

        calendarPickerView.frame = CGRect(
            x: 0,
            y: maxY,
            width: UIScreen.width,
            height: 0.0
        )
        
        baseView.insertSubview(calendarPickerView, belowSubview: calendarButton.superview!)
//        baseView.addSubview(calendarPickerView)
//        baseView.insertSubview(blurView, belowSubview: calendarPickerView)

        UIView.animate(
            withDuration: 0.3,
            animations: { [weak self] in

                guard let strongSelf = self else { return }

                let height =
                451.0 / 586.0 * strongSelf.recordTableView.frame.height

                self?.calendarPickerView.frame = CGRect(
                    x: 0,
                    y: maxY - height,
                    width: UIScreen.width,
                    height: maxY
                )
            }
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
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

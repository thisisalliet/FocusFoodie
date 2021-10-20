//
//  RecordViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit

class RecordViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var calendarButton: UIButton!
    
    @IBOutlet weak var profileView: ProfileView!
    
    @IBOutlet weak var recordTableView: UITableView! {
        
        didSet {
            
            recordTableView.dataSource = self
            
            recordTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    private func setUpTableView() {
        
        recordTableView.registerCellWithNib(identifier:
            String(describing: RecordTableViewCell.self),
                                            bundle: nil
        )
    }
    
    // MARK: - UITableViewDataSource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = recordTableView.dequeueReusableCell(
            withIdentifier: String(describing: RecordTableViewCell.self),
            for: indexPath
        )
        
        guard let cell = cell as? RecordTableViewCell else { return cell }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate -

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

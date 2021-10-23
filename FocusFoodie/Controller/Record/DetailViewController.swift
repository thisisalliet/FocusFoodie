//
//  DetailViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/21.
//

import UIKit

class DetailViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var detailTableView: UITableView! {
        
        didSet {
            
            detailTableView.dataSource = self
            
            detailTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    private func setUpTableView() {
        
        detailTableView.registerCellWithNib(identifier:
            String(describing: DetailImageTableViewCell.self),
                                            bundle: nil
        )
        
        detailTableView.registerCellWithNib(identifier:
            String(describing: DetailSelectionCell.self),
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
            
            return imageCell
            
        case 1:
            guard let selectCell = detailTableView.dequeueReusableCell(
                withIdentifier: String(describing: DetailSelectionCell.self),
                for: indexPath
            ) as? DetailSelectionCell else {fatalError("Couldn't generate selectCell")}
            
            return selectCell
            
        case 2:
            
            guard let noteCell = detailTableView.dequeueReusableCell(
                withIdentifier: String(describing: DetailNoteTableViewCell.self),
                for: indexPath
            ) as? DetailNoteTableViewCell else {fatalError("Couldn't generate noteCell")}
            
            return noteCell
            
        default:
            return DetailImageTableViewCell()
        }
    }
}

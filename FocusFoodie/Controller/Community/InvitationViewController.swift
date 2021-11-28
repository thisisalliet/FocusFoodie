//
//  InvitationViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/26.
//

import UIKit

class InvitationViewController: CompondViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    // MARK: - Private method
    
    private func setupTableView() {

        tableView.separatorStyle = .none

        tableView.backgroundColor = UIColor.G1

        tableView.registerCellWithNib(
            identifier: "CommunityTableViewCell",
            bundle: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

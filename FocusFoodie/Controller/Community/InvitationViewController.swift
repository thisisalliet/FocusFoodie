//
//  InvitationViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/26.
//

import UIKit

class InvitationViewController: CompoundViewController {
    
    let myId = UserManager.shared.currentUserId
    
    var sender: String = ""
    
    var senderInfo: [String: User] = [:]
    
    var invitations: [Invitation]?
    
    var invitationNumberHandler: ((_ number: Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: - Private Method -
    
    private func setupTableView() {
        
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.G1
        
        tableView.registerCellWithNib(
            identifier: CommunityTableViewCell.identifier,
            bundle: nil)
    }
    
    // MARK: - Public Method -
    
    func monitorInvitation() {
        
        InvitationManager.shared.monitorInvitation { [self] result in
            
            switch result {
                
            case .success(let invitations):
                
                let group = DispatchGroup()
                
                self.invitations = invitations
                
                for sender in invitations {
                    
                    group.enter()
                    
                    UserManager.shared.fetchUserInfo(uid: sender.senderId) { result in
                        
                        switch result {
                            
                        case .success(let senderInfo):
                            
                            self.senderInfo[sender.senderId] = senderInfo
                            
                            group.leave()
                            
                        case .failure(let error):
                            
                            print("fetch sender info \(error)")
                            
                            group.leave()
                        }
                    }
                }
                
                group.notify(queue: .main) {
                    
                    tableView.dataSource = self
                    
                    tableView.delegate = self
                    
                    tableView.reloadData()
                }
                
            case .failure(let error):
                
                print("fetchAllInvitation.failure: \(error)")
            }
        }
    }
    
    func acceptInvitation(at index: Int) {
        
        InvitationManager.shared.acceptInvitation(
            userId: myId,
            invitorId: invitations?[index].senderId ?? "") { result in
                
                switch result {
                    
                case .success(let acceptInvitation):
                    
                    print("Add friend succesfully")
                    
                case .failure(let error):
                    
                    print(error)
                }
            }
    }
    
    // MARK: - UITableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let invitationNumberHandler = invitationNumberHandler else {
            return 0 }
        
        invitationNumberHandler(invitations?.count ?? 0)
        
        return invitations?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommunityTableViewCell.identifier,
            for: indexPath
        ) as? CommunityTableViewCell else {
            
            fatalError("cannot dequeue tableViewCell")
        }
        
        guard let senderId = invitations?[indexPath.row].senderId else {
            
            fatalError("cannot fetch invitations")
        }
        
        cell.layoutCellWithInvitation(
            name: senderInfo[senderId]?.displayName ?? "",
            email: senderInfo[senderId]?.userEmail ?? "")
        
        cell.touchHandler = { [weak self] in
            
            self?.acceptInvitation(at: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        let onIgnore = UIContextualAction(style: .normal, title: "") { (action, view, completionHandler) in
            
            completionHandler(true)
        }
        
        onIgnore.backgroundColor = .G1
        
        onIgnore.image = .asset(.icon_cross_green)
                
        self.invitations?.remove(at: indexPath.row)
        
        return UISwipeActionsConfiguration(actions: [onIgnore])
    }
}

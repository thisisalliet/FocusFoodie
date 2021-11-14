//
//  CommunityListViewController.swift
//  
//
//  Created by Allie T on 2021/11/13.
//

import UIKit

class CommunityListViewController: CompondViewController {

    
    var sender: [User] = [] {
        
        didSet {
            
            tableView.dataSource = self
            
            tableView.reloadData()
        }
    }
    
    var friendList = [FriendList]() {
        
        didSet {
            
            tableView.reloadData()
        }
    }
    
    var invitations = [Invitation]() {
        
        didSet {
            
            tableView.reloadData()
        }
    }
    
    var blockList = [BlockList]() {
        
        didSet {
            
            tableView.reloadData()
        }
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
        
        setUpTableView()
                        
        monitorInvitation()
    }
    
    private func setUpTableView() {
        
        tableView.separatorStyle = .none

        tableView.backgroundColor = .G3
        
        tableView.registerCellWithNib(
            identifier: String(describing: CommunityTableViewCell.self),
            bundle: nil
        )
    }
    
    func monitorInvitation() {
        
        UserManager.shared.monitorInvitation(uid: myId) { [self] result in
            
            switch result {
                
            case .success(let myInvite):
                
                self.invitations.removeAll()
                
                self.invitations.append(contentsOf: myInvite)
                
                searchInviter(invitation: myInvite)
                
                invitationNumber.text = "\(myInvite.count)"
                
                print(myInvite)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func searchInviter(invitation: [Invitation]) {
        
        let group = DispatchGroup()
        
        var sender = [User]()
        
        DispatchQueue.main.async {
            
            invitation.forEach { invitation in
                
                group.enter()
                
                UserManager.shared.fetchUserInfo(uid: invitation.senderId) { [self] result in
                    
                    switch result {
                        
                    case .success(let user):
                        
                        sender.append(user)
                        
                        group.leave()
                        
                    case .failure(let error):
                        print(error)
                        
                        group.leave()
                    }
                }
            }
            
            group.notify(queue: DispatchQueue.main) { [self] in
                
                self.sender = sender
            }
        }
    }
    
    @objc func acceptButtonTapped() {
        
        guard let senderId = senderId else {
            return
        }
        
        UserManager.shared.addFriend(
            userId: myId,
            invitorId: senderId)
    }
    
    // MARK: - UITableView DataSource -

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return invitations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: CommunityTableViewCell.self),
            for: indexPath)
        
        guard let communityCell = cell as? CommunityTableViewCell,
              let community = datas[indexPath.section][indexPath.row] as? User
        else {

            return cell
        }
        
        communityCell.layoutCell(
            name: community.displayName,
            email: community.userEmail)
        
        communityCell.acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
                
        return invitationCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        guard let community = datas[indexPath.section][indexPath.row] as? User else { return }
        
        acceptButtonTapped()
        
//        senderId = sender[indexPath.row].userId
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let declineAction = UIContextualAction(style: .destructive, title: "") {
            (action, sourceView, complete) in
            
            self.sender.remove(at: indexPath.row)
            
            self.communityTableView.deleteRows(at: [indexPath], with: .top)
            
            complete(true)
        }
        
        declineAction.backgroundColor = .G1
        
        declineAction.image = UIGraphicsImageRenderer(
            size: CGSize(width: 40.0, height: 40.0)).image(
            actions: { _ in UIImage.asset(.icon_delete)?.draw(
                in: CGRect(x: 0, y: 0, width: 40, height: 40))
            })
        
        let trailingSwipConfiguration = UISwipeActionsConfiguration(actions: [declineAction])
        
        return trailingSwipConfiguration
    }
    
    // MARK: Tableview Delegate -
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        UITableView.automaticDimension
    }
}

//
//  CommunityViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class CommunityViewController: BaseViewController,
                               UITableViewDataSource,
                               UITableViewDelegate {
    
    @IBOutlet weak var yourCommunityLabel: UILabel!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var friendNumber: UILabel!
    
    @IBOutlet weak var pendingNumber: UILabel!
    
    @IBOutlet weak var blockNumber: UILabel!
    
    @IBOutlet weak var friendLabel: UILabel!
    
    @IBOutlet weak var pendingLabel: UILabel!
    
    @IBOutlet weak var blockLabel: UILabel!
    
    @IBOutlet weak var communityTableView: UITableView!
    
    let myId = UserManager.shared.userId
    
    var senderId: String?
    
    var db: Firestore!
    
    var sender: [User] = [] {
        
        didSet {
            
            communityTableView.dataSource = self
            
            communityTableView.reloadData()
        }
    }
        
    var friendList = [FriendList]() {
        
        didSet {
            
            communityTableView.reloadData()
        }
    }
    
    var invitations = [Invitation]() {
        
        didSet {
            
            communityTableView.reloadData()
        }
    }
    
    var blockList = [BlockList]() {
        
        didSet {
            
            communityTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        setUpTableView()
        
        communityTableView.delegate = self
        
        //        fetchFriendList()
        
        monitorInvitation()
        
        //        monitorFriendList()
    }
    
    private func setUpTableView() {
        
        communityTableView.registerCellWithNib(identifier: String(describing: CommunityTableViewCell.self),
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
                
                pendingNumber.text = "\(myInvite.count)"
                
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
    
//    func monitorFriendList() {
//
//        db.collection(CollectionName.user.rawValue).addSnapshotListener { snapshot, error in
//            guard let snapshot = snapshot else { return }
//
//            if !snapshot.documentChanges.isEmpty {
//
//                self.fetchFriendList()
//            }
//        }
//    }
    
//    func fetchFriendList() {
//
//        db.collection(CollectionName.user.rawValue).document(myId).getDocument { document, error in
//
//            guard let document = document,
//                  document.exists,
//                  let user = try? document.data(as: User.self)
//            else { return }
//
//            self.friendList.removeAll()
//
//            self.friendList = user.friendList ?? []
//        }
//    }
    
    @objc func acceptButtonTapped() {
        
        guard let senderId = senderId else {
            return
        }
        
        UserManager.shared.addFriend(
            userId: myId,
            invitorId: senderId)
    }
    
    // MARK: Tableview Datasource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return invitations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let invitationCell = communityTableView.dequeueReusableCell(
            withIdentifier: String(describing: CommunityTableViewCell.self),
            for: indexPath) as? CommunityTableViewCell
        else { fatalError() }
        
        invitationCell.nameLabel.text = sender[indexPath.row].displayName
        
        invitationCell.emailLabel.text = sender[indexPath.row].userEmail
        
        invitationCell.acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        
        //            invitationCell.delegate = self
        
        return invitationCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        senderId = sender[indexPath.row].userId
    }
    
    
    
//    func tableView(_ tableView: UITableView,
//                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let declineAction = UIContextualAction(style: .normal, title: "") {
//            (action, view, completionHandler) in completionHandler( true )
//        }
//
//        declineAction.backgroundColor = .orange
//
//        return UISwipeActionsConfiguration(actions: [declineAction])
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let declineAction = UIContextualAction(style: .destructive, title: "") { (action, sourceView, complete) in
            
            self.sender.remove(at: indexPath.row)
            
            self.communityTableView.deleteRows(at: [indexPath], with: .top)
            
            complete(true)
        }
        
        declineAction.backgroundColor = .G1
                                
        declineAction.image = UIGraphicsImageRenderer(size: CGSize(width: 40.0, height: 40.0)).image(actions: { _ in UIImage.asset(.icon_delete)?.draw(in: CGRect(x: 0, y: 0, width: 40, height: 40))
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

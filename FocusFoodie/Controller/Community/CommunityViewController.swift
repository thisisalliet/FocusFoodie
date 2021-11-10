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
    
    let myId = UserManager.shared.userId
    
    var db: Firestore!
    
    var user: [User] = [] {
        
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
    
    var pendingList = [BlockList]() {
        
        didSet {
            
            communityTableView.reloadData()
        }
    }
    
    var invitations = [Invitation]() {
        
        didSet {
            
            communityTableView.reloadData()
        }
    }
    
    @IBOutlet weak var yourCommunityLabel: UILabel!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var friendNumber: UILabel!
    
    @IBOutlet weak var friendLabel: UILabel!
    
    @IBOutlet weak var pendingNumber: UILabel!
    
    @IBOutlet weak var pendingLabel: UILabel!
    
    @IBOutlet weak var blockNumber: UILabel!
    
    @IBOutlet weak var blockLabel: UILabel!
    
    @IBOutlet weak var communityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        setUpTableView()
        
        fetchInvitations()
        
        fetchFriendList()
        
        monitorInvitation()
        
        monitorFriendList()
        
        searchUid()
        
        communityTableView.delegate = self
    }
    
    // MARK: - Awake Nib -
    private func setUpTableView() {
        
        communityTableView.registerCellWithNib(identifier: String(describing: CommunityTableViewCell.self),
                                               bundle: nil
        )
    }
    
    func monitorInvitation() {
        
        db.collection(CollectionName.invitation.rawValue).addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            if !snapshot.documentChanges.isEmpty {
                
                self.fetchInvitations()
            }
        }
    }
    
    func monitorFriendList() {
        
        db.collection(CollectionName.user.rawValue).addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            if !snapshot.documentChanges.isEmpty {
                
                self.fetchFriendList()
            }
        }
    }
    
    func fetchInvitations() {
        
        db.collection(CollectionName.invitation.rawValue).getDocuments { [self] snapshot, error in
            
            guard let snapshot = snapshot else { return }
            
            let allInvitations = snapshot.documents.compactMap { snapshot in
                try? snapshot.data(as: Invitation.self)
            }
            
            let myInvite = allInvitations.filter({ $0.receiverId == myId})
            
            self.invitations.removeAll()
            
            self.invitations.append(contentsOf: myInvite)
        }
    }
    
    func fetchFriendList() {
        
        db.collection(CollectionName.user.rawValue).document(myId).getDocument { document, error in
            
            guard let document = document,
                  document.exists,
                  let user = try? document.data(as: User.self)
            else { return }
            
            self.friendList.removeAll()
            
            self.friendList = user.friendList ?? []
        }
    }
    
    func searchUid() {
        
        friendList.forEach { friend in
            
            UserManager.shared.fetchUserInfo(uesrId: friend.friendId) { result in
                
                switch result {
                    
                case .success(let user):
                    self.user.append(user)
                    
                case .failure(let error):
                    print(error)
                    
                default: break
                }
            }
        }
    }
    
    // MARK: Tableview Datasource -
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rows = 1
        
        //        rows += invitations.count
        
        rows += friendList.count
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let invitationCell = communityTableView.dequeueReusableCell(withIdentifier:
                                                                            String(describing: CommunityTableViewCell.self),
                                                                          for: indexPath) as? CommunityTableViewCell else { fatalError() }
        
        //            invitationCell.delegate = self
        
        invitationCell.nameLabel.text = user[indexPath.row].displayName
        
        invitationCell.emailLabel.text = user[indexPath.row].userEmail
        
        return invitationCell
        
    }
    
    // MARK: Tableview Delegate -
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        UITableView.automaticDimension
    }
}

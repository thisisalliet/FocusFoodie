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
    
    enum ButtonType: Int {
        
        case friend = 0
        
        case invitation = 1
        
        case block = 2
    }
    
    @IBOutlet weak var yourCommunityLabel: UILabel!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var friendNumber: UILabel!
    
    @IBOutlet weak var invitationNumber: UILabel!
    
    @IBOutlet weak var blockNumber: UILabel!
    
    @IBOutlet weak var friendLabel: UILabel!
    
    @IBOutlet weak var invitationLabel: UILabel!
    
    @IBOutlet weak var blockLabel: UILabel!
    
    @IBOutlet weak var friendContainerView: UIView!
    
    @IBOutlet weak var invitationContainerView: UIView!
    
    @IBOutlet weak var blockContainerView: UIView!
    
    @IBOutlet var communityButtons: [UIButton]!
    
    @IBOutlet weak var indicatorView: UIView! {
        
        didSet {
            
            indicatorView.cornerRadius = indicatorView.frame.height / 2
        }
    }
    
    @IBOutlet weak var indicatorCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var communityTableView: UITableView! {
        
        didSet {
            
            self.communityTableView.dataSource = self
            
            self.communityTableView.delegate = self
        }
    }
    
    let myId = UserManager.shared.userId
    
    var db: Firestore!
    
    var userInfo: [String: User] = [:]
//    {
//
//        didSet {
//
//            communityTableView.reloadData()
//        }
//    }
    
    var listType: ButtonType? {
        
        didSet {
            
            switch listType {
                
            case .friend: updateFriendBlockList(type: CommunityType.friend)
                
            case .invitation: updateInvitationList(type: CommunityType.invitation )
                
            case .block: updateFriendBlockList(type: CommunityType.block)
                
            default:
                break
            }
        }
    }
    
    var layout: CommunityLayout?
    
    var communityList = [Any]() {
        
        didSet {
            
            searchUser()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
//        setUpNumbers()
    }
    
    // MARK: - Action
    @IBAction func onChangeCommunity(_ sender: UIButton) {
        
        for btn in communityButtons {
            
            btn.isSelected = false
        }
        
        sender.isSelected = true
        
        changeContent(reference: sender)
        
        switch sender.tag {
            
        case 0: listType = .friend
            layout = .basic
            
        case 1: listType = .invitation
            layout = .withInvitation
            
        case 2: listType = .block
            layout = .basic
            
        default:
            break
        }
    }
    
    // MARK: - Private method -
    private func setUpTableView() {
        
        communityTableView.registerCellWithNib(
            identifier: String(describing: CommunityTableViewCell.self),
            bundle: nil)
        
        communityTableView.separatorStyle = .none
    }
    
    private func changeContent(reference: UIView) {
        
        indicatorCenterXConstraint.isActive = false
        
        indicatorCenterXConstraint = indicatorView.centerXAnchor.constraint(equalTo: reference.centerXAnchor)
        
        indicatorCenterXConstraint.isActive = true
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            
            self?.view.layoutIfNeeded()
        })
    }
    
//    private func setUpNumbers() {
//
//        friendNumber.text = "\(communityList.count)"
//
//        invitationNumber.text = "\(communityList.count)"
//
//        blockNumber.text = "\(communityList.count)"
//    }
    
    private func updateFriendBlockList(type: CommunityType) {
        
        UserManager.shared.fetchFriendBlockList(type) { result in
            
            switch result {
                
            case .success(let friendBlockList):
                self.communityList = friendBlockList
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateInvitationList(type: CommunityType) {
        
        InvitationManager.shared.monitorInvitation(uid: myId) { result in
            
            switch result {
                
            case .success(let invitationList):
                self.communityList = invitationList
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchUser() {
        
        switch listType {
            
        case .friend:
            
            let friendList = communityList as? [FriendList]
            
            friendList?.forEach({ friendList in
                
                UserManager.shared.fetchUserInfo(uid: friendList.friendId) { result in
                    
                    switch result {
                        
                    case .success(let user):
                        
                        guard let name = user.displayName else { return }
                        
                        self.userInfo[name] = user
                        
                        self.communityTableView.reloadData()
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            })
            
        case .invitation:
            
            let invitation = communityList as? [Invitation]
            
            invitation?.forEach({ invitation in
                
                UserManager.shared.fetchUserInfo(uid: invitation.senderId) { result in
                    
                    switch result {
                        
                    case .success(let user):
                        
                        guard let name = user.displayName else { return }
                        
                        self.userInfo[user.userId] = user
                        
                    case .failure(let error):
                        
                        print(error)
                    }
                }
            })
            
            self.communityTableView.reloadData()
            
        case .block:
            
            let blockList = communityList as? [BlockList]
            
            blockList?.forEach({ blockList in
                
                UserManager.shared.fetchUserInfo(uid: blockList.blockId) { result in
                    
                    switch result {
                        
                    case .success(let user):
                        
                        guard let name = user.displayName else { return }
                        
                        self.userInfo[user.userId] = user
                        
                    case .failure(let error):
                        
                        print(error)
                    }
                }
            })
            
        default:
            break
        }
    }
    
    // MARK: - UITabelview Datasource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 檢查 reload data 的時間點
        return communityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 檢查 reload data 的時間點
        let cell = communityTableView.dequeueReusableCell(
            withIdentifier: String(describing: CommunityTableViewCell.self),
            for: indexPath)
        
        let key = communityList[indexPath.row]
        
        guard let communityCell = cell as? CommunityTableViewCell
                
        else {
            
            return cell
        }
        
        switch layout {
            
        case .basic:
            
            if let friendBlock = key as? User,
               let userId = friendBlock.userId as? String {
                
                communityCell.layoutCell(
                    name: userInfo[userId]?.displayName ?? "",
                    email: userInfo[userId]?.userEmail ?? "")
            }
            
        case .withInvitation:
            
            if let invitation = key as? Invitation,
               let senderId = invitation.senderId as? String {
                
                communityCell.layoutCellWithInvitation(
                    name:  userInfo[senderId]?.displayName ?? "",
                    email: userInfo[senderId]?.userEmail ?? "")
            }
            
        default:
            break
        }
        
        return communityCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let onDecline = UIContextualAction(style: .normal, title: "") { (action, view, completionHandler) in
          
            completionHandler(true)
        }
        
        onDecline.backgroundColor = .G1
        
        onDecline.image = .asset(.icon_delete)
        
        return UISwipeActionsConfiguration(actions: [onDecline])
    }
    
    // MARK: - UITabelview Delegate -
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

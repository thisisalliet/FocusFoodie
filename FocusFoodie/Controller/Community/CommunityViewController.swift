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


class CommunityViewController: BaseViewController {
    
    enum CommunityType: Int {
        
        case friend = 0
        
        case invitation = 1
        
        case block = 2
    }
    
    private struct Segue {

        static let friend = "SegueFriend"

        static let invitation = "SegueInvitation"

        static let block = "SegueBlock"
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
    
    let myId = UserManager.shared.currentUserId
    
    var db: Firestore!
    
    var firendBlockVC: CompondViewController?
    
    var userInfo: [String: User] = [:]
    
    var containerViews: [UIView] {

        return [friendContainerView, invitationContainerView, blockContainerView]
    }
    
//    var listType: ButtonType? {
//
//        didSet {
//
//            switch listType {
//
//            case .friend: updateFriendBlockList(type: CommunityType.friend)
//
//            case .invitation: updateInvitationList(type: CommunityType.invitation )
//
//            case .block: updateFriendBlockList(type: CommunityType.block)
//
//            default:
//                break
//            }
//        }
//    }
    
//    var layout: CommunityLayout?
    
//    var communityList = [Any]() {
//
//        didSet {
//
//            searchUser()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
    // MARK: - Action
    
    @IBAction func onChangeCommunity(_ sender: UIButton) {
        
        for button in communityButtons {

            button.isSelected = false
        }

        sender.isSelected = true

        moveIndicatorView(reference: sender)

        guard let type = CommunityType(rawValue: sender.tag) else { return }

        updateContainer(type: type)
//    }
        
//        for btn in communityButtons {
//
//            btn.isSelected = false
//        }
//
//        sender.isSelected = true
//
//        changeContent(reference: sender)
//
//        switch sender.tag {
//
//        case 0: listType = .friend
//            layout = .basic
//
//        case 1: listType = .invitation
//            layout = .withInvitation
//
//        case 2: listType = .block
//            layout = .basic
//
//        default:
//            break
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let identifier = segue.identifier
        
        if identifier == Segue.friend,
           let friendVC = segue.destination as? FriendBlockViewController {
            
            friendVC.friendNumberHandler = { [weak self] number in
                
                guard let strongSelf = self else { return }
                
                strongSelf.friendNumber.text = "\(number)"
            }
            
            friendVC.monitorFriendList()
            
            self.firendBlockVC = friendVC

        } else if identifier == Segue.invitation,
                  let invitationVC = segue.destination as? InvitationViewController {
            
            invitationVC.invitationNumberHandler = { [weak self] number in
                
                guard let strongself = self else { return }
                
                strongself.invitationNumber.text = "\(number)"
            }
            
            invitationVC.monitorInvitation()

        } else if identifier == Segue.block,
                  let blockVC = segue.destination as? FriendBlockViewController {
            
            blockVC.blockNumberHandler = { [weak self] number in
                
                guard let strongSelf = self else { return }
                
                strongSelf.blockNumber.text = "\(number)"
            }
            
            blockVC.monitorBlockList()
        }
    }
    
    // MARK: - Private method -
    
    private func moveIndicatorView(reference: UIView) {
        
        indicatorCenterXConstraint.isActive = false
        
        indicatorCenterXConstraint = indicatorView.centerXAnchor.constraint(equalTo: reference.centerXAnchor)
        
        indicatorCenterXConstraint.isActive = true
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            
            self?.view.layoutIfNeeded()
        })
    }
    
    private func updateContainer(type: CommunityType) {

        containerViews.forEach({ $0.isHidden = true })

        switch type {

        case .friend:
            friendContainerView.isHidden = false
            
            guard let firendBlockVC = firendBlockVC as? FriendBlockViewController else { return }

            firendBlockVC.friendBlockType = .friend

        case .invitation:
            invitationContainerView.isHidden = false

        case .block:
            blockContainerView.isHidden = false
            
            guard let firendBlockVC = firendBlockVC as? FriendBlockViewController else { return }

            firendBlockVC.friendBlockType = .block
        }
    }
    
//    private func updateFriendBlockList(type: CommunityType) {
//
//        UserManager.shared.fetchFriendBlockList(type) { result in
//
//            switch result {
//
//            case .success(let friendBlockList):
//                self.communityList = friendBlockList
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
//    private func updateInvitationList(type: CommunityType) {
//
//        InvitationManager.shared.monitorInvitation(uid: myId) { result in
//
//            switch result {
//
//            case .success(let invitationList):
//                self.communityList = invitationList
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
//    func searchUser() {
//
//        switch listType {
//
//        case .friend:
//
//            let friendList = communityList as? [FriendList]
//
//            friendList?.forEach({ friendList in
//
//                UserManager.shared.fetchUserInfo(uid: friendList.friendId) { result in
//
//                    switch result {
//
//                    case .success(let user):
//
//                        guard let name = user.displayName else { return }
//
//                        self.userInfo[name] = user
//
//                        self.communityTableView.reloadData()
//
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//            })
//
//        case .invitation:
//
//            let invitation = communityList as? [Invitation]
//
//            invitation?.forEach({ invitation in
//
//                UserManager.shared.fetchUserInfo(uid: invitation.senderId) { result in
//
//                    switch result {
//
//                    case .success(let user):
//
//                        guard let name = user.displayName else { return }
//
//                        self.userInfo[user.userId] = user
//
//                    case .failure(let error):
//
//                        print(error)
//                    }
//                }
//            })
//
//            self.communityTableView.reloadData()
//
//        case .block:
//
//            let blockList = communityList as? [BlockList]
//
//            blockList?.forEach({ blockList in
//
//                UserManager.shared.fetchUserInfo(uid: blockList.blockId) { result in
//
//                    switch result {
//
//                    case .success(let user):
//
//                        guard let name = user.displayName else { return }
//
//                        self.userInfo[user.userId] = user
//
//                    case .failure(let error):
//
//                        print(error)
//                    }
//                }
//            })
//
//        default:
//            break
//        }
//    }
}

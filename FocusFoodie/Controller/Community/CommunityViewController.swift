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
    
    var friendVC: CompoundViewController?
    
    var blockVC: CompoundViewController?
    
    var userInfo: [String: User] = [:]
    
    var containerViews: [UIView] {

        return [friendContainerView, invitationContainerView, blockContainerView]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
    // MARK: - Button Action -
    
    @IBAction func onChangeCommunity(_ sender: UIButton) {
        
        for button in communityButtons {

            button.isSelected = false
        }

        sender.isSelected = true

        moveIndicatorView(reference: sender)

        guard let type = CommunityType(rawValue: sender.tag) else { return }

        updateContainer(type: type)
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
            
            self.friendVC = friendVC

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
            
            self.blockVC = blockVC
        }
    }
    
    // MARK: - Private Method -
    
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
            
            guard let friendVC = friendVC as? FriendBlockViewController else { return }

            friendVC.friendBlockType = .friend
            
            friendVC.tableView.reloadData()

        case .invitation:
            invitationContainerView.isHidden = false

        case .block:
            blockContainerView.isHidden = false
            
            guard let blockVC = blockVC as? FriendBlockViewController else { return }

            blockVC.friendBlockType = .block
            
            blockVC.tableView.reloadData()
        }
    }
}

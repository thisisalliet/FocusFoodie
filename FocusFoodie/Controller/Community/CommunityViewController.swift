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
    
    private enum CommunityType: Int {

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
    
    let myId = UserManager.shared.userId
    
    var containerViews: [UIView] {

        return [friendContainerView, invitationContainerView, blockContainerView]
    }
    
    var senderId: String?
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Action
    @IBAction func onChangeProducts(_ sender: UIButton) {

        for btn in communityButtons {

            btn.isSelected = false
        }

        sender.isSelected = true

        changeButtonColor(reference: sender)

        guard let type = CommunityType(rawValue: sender.tag) else { return }

        updateContainer(type: type)
    }
    
    private func changeButtonColor(reference: UIView) {

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

        case .invitation:
            invitationContainerView.isHidden = false

        case .block:
            blockContainerView.isHidden = false
        }
    }
}

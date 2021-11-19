//
//  File.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/19.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class CommunityProvider: CommunityListDataProvider {

    enum CommunityType {

        case friends

        case invitations

        case blocks
    }
    
    private let communityType: CommunityType

    private let dataProvider: UserManager
    
    let myId = UserManager.shared.userId
    
    var invitations = [Invitation]()

    init(communityType: CommunityType, dataProvider: UserManager) {

        self.communityType = communityType

        self.dataProvider = dataProvider
    }
    
//    func fetchData() {
//
//        switch communityType {
//
//        case .friends:
            
//            dataProvider.monitorInvitation(uid: myId) { [self] result in
//
//                switch result {
//
//                case .success(let myInvite):
//
//                    self.invitations.removeAll()
//
//                    self.invitations.append(contentsOf: myInvite)
//
//                    searchInviter(invitation: myInvite)
//
//                    invitationNumber.text = "\(myInvite.count)"
//
//                    print(myInvite)
//
//                case .failure(let error):
//
//                    print(error)
//                }
//            }
//        case .invitations:
//            
//        case .blocks:
//            
//        }
//    }
}

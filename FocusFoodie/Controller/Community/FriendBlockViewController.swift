//
//  BlockViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/26.
//

import UIKit

class FriendBlockViewController: CompoundViewController {
    
    enum FriendBlockType: String {
        
        case friend = "Friends"
        
        case block = "Blocks"
    }
    
    let myId = UserManager.shared.currentUserId
    
    var friendBlockType: FriendBlockType = .friend
    
    var friends: [String] = []
    
    var blocks: [String] = []
    
    var friendInfo: [String: User] = [:]
    
    var blockInfo: [String: User] = [:]
    
    var friendNumberHandler: ((_ number: Int) -> Void)?
    
    var blockNumberHandler: ((_ number: Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: - Private method
    
    private func setupTableView() {
        
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.G1
        
        tableView.registerCellWithNib(
            identifier: CommunityTableViewCell.identifier,
            bundle: nil)
    }
    
    func monitorFriendList() {
        
        UserManager.shared.monitorUserInfo { [self] result in
            
            switch result {
                
            case .success(let friendInfo):
                
                let group = DispatchGroup()
                
                self.friends = friendInfo.friendList ?? []
                
                for friend in self.friends {
                    
                    group.enter()
                    
                    UserManager.shared.fetchUserInfo(uid: friend) { result in
                        
                        switch result {
                            
                        case .success(let friends):
                            
                            self.friendInfo[friend] = friends
                                                        
                            group.leave()
                            
                        case .failure(let error):
                            
                            print("fetcFriendData.failure: \(error)")
                            
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
                
                print("fetchFriendList.failure: \(error)")
            }
        }
    }
    
    func monitorBlockList() {
        
        UserManager.shared.monitorUserInfo { [self] result in
            
            switch result {
                
            case .success(let blockInfo):
                
                let group = DispatchGroup()
                                
                self.blocks = blockInfo.blockList ?? []
                
                for block in self.blocks {
                    
                    group.enter()
                    
                    UserManager.shared.fetchUserInfo(uid: block) { result in
                        
                        switch result {
                            
                        case .success(let blocks):
                            
                            self.blockInfo[block] = blocks
                            
                            print(blocks)
                            
                            group.leave()
                            
                        case .failure(let error):
                            
                            print("fetchBlockData.failure: \(error)")
                            
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
                print("fetchBlockList.failure: \(error)")
            }
        }
    }
    
    func unFriend(at index: Int) {
        
        UserManager.shared.removeFriend(
            userId: friends[index]) { result in
                
                switch result {
                    
                case .success(let unFriend):
                    
                    print("remove friend succesfully")
                    
                case .failure(let error):
                    
                    print(error)
                }
                
                self.tableView.reloadData()
            }
    }
    
    func reFriend(at index: Int) {
        
        UserManager.shared.removeBlock(userId: blocks[index]) { result in
            
            switch result {
                
            case .success(let reFriend):
                
                print("Re-add friend succesfully")
                
            case .failure(let error):
                
                print(error)
            }
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - UITableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch friendBlockType {
            
        case .friend:
            
            guard let friendNumberHandler = friendNumberHandler else {
                return friends.count }
            
            friendNumberHandler(friends.count)
                        
            return friends.count
            
        case .block:
            
            guard let blockNumberHandler = blockNumberHandler else {
                return blocks.count }
            
            blockNumberHandler(blocks.count)
            
            return blocks.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommunityTableViewCell.identifier,
            for: indexPath
        ) as? CommunityTableViewCell else {
            fatalError("cannot dequeue tableViewCell")
        }
        
        switch friendBlockType {
            
        case .friend:
            
            let friendId = friends[indexPath.row]
            
            guard let friendInfo = friendInfo[friendId] else {
                return cell
            }
            
            cell.layoutCell(
                name: friendInfo.displayName ?? "",
                email: friendInfo.userEmail ?? "")
            
            cell.touchHandler = { [weak self] in
                
                self?.unFriend(at: indexPath.row)
                
                self?.blocks.append(self?.friends[indexPath.row] ?? "")
                
                self?.friends.remove(at: indexPath.row)
            }
            
        case .block:
            
            let blockId = blocks[indexPath.row]
            
            guard let blockInfo = blockInfo[blockId] else {
                return cell
            }
            
            cell.layoutCell(
                name: blockInfo.displayName ?? "",
                email: blockInfo.userEmail ?? "")
            
            cell.touchHandler = { [weak self] in
                
                self?.reFriend(at: indexPath.row)
                
                self?.friends.append(self?.blocks[indexPath.row] ?? "")
                
                self?.blocks.remove(at: indexPath.row)
            }        }
        
        return cell
    }
}

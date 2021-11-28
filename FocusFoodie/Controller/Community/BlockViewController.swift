//
//  BlockViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/26.
//

import UIKit

class BlockViewController: CompondViewController {
    
    let myId = UserManager.shared.currentUserId
    
    var friends: [String] = []
    
    var blocks: [String] = []
    
    var blockInfo: [String: User] = [:]
    
    var blockNumberHandler: ((_ number: Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        fetchBlockList()
    }
    
    // MARK: - Private method
    
    private func setupTableView() {
        
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.G1
        
        tableView.registerCellWithNib(
            identifier: String(describing: CommunityTableViewCell.self),
            bundle: nil)
    }
    
    func fetchBlockList() {
        
        UserManager.shared.fetchUserInfo(uid: myId) { [self] result in
            
            switch result {
                
            case .success(let blockInfo):
                
                let group = DispatchGroup()
                
                self.friends = blockInfo.friendList ?? []
                
                self.blocks = blockInfo.blockList ?? []
                
                for block in self.blocks {
                    
                    group.enter()
                    
                    UserManager.shared.fetchUserInfo(uid: block) {
                        
                        result in
                        
                        switch result {
                            
                        case .success(let blocks):
                            
                            self.blockInfo[block] = blocks
                            
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
    
    // MARK: - UITableView DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let blockNumberHandler = blockNumberHandler else { return 0 }

        blockNumberHandler(blocks.count)
        
        return blocks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommunityTableViewCell.identifier,
                    for: indexPath
                ) as? CommunityTableViewCell else {
                    fatalError("can not dequeue tableViewCell")
                }
                
        let blockId = blocks[indexPath.row]
        guard let blockInfo = blockInfo[blockId] else {
            return cell
        }
        
        cell.layoutCell(
            name: blockInfo.displayName ?? "",
            email: blockInfo.userEmail ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        let onRemove = UIContextualAction(style: .normal, title: "") { (action, view, completionHandler) in
            
            completionHandler(true)
        }
        
        onRemove.backgroundColor = .G1
        
        onRemove.image = .asset(.icon_cross_yellow)
        
        let friendId = friends[indexPath.row]
        UserManager.shared.removeFriend(userId: friendId) { result in
            
            switch result {
                
            case .success(let reFriend):
                
                print("remove block succesfully")
                
            case .failure(let error):
                
                print(error)
            }
        }
        
        return UISwipeActionsConfiguration(actions: [onRemove])
    }
}

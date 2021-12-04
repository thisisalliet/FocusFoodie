//
//  FriendBlockViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/26.
//

import UIKit

//class FriendViewController: CompondViewController {
//
//    let myId = UserManager.shared.currentUserId
//
//    var friends: [String] = []
//
//    var blocks: [String] = []
//
//    var friendInfo: [String: User] = [:]
//
//    var friendNumberHandler: ((_ number: Int) -> Void)?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupTableView()
//
//        fetchFriendList()
//    }
//
//    // MARK: - Private method
//
//    private func setupTableView() {
//
//        tableView.separatorStyle = .none
//
//        tableView.backgroundColor = UIColor.G1
//
//        tableView.registerCellWithNib(
//            identifier: String(describing: CommunityTableViewCell.self),
//            bundle: nil)
//    }
//
//    func fetchFriendList() {
//
//        UserManager.shared.fetchUserInfo(uid: myId) { [self] result in
//
//            switch result {
//
//            case .success(let friendInfo):
//
//                let group = DispatchGroup()
//
//                self.friends = friendInfo.friendList ?? []
//
//                self.blocks = friendInfo.blockList ?? []
//
//                for friend in self.friends {
//
//                    group.enter()
//
//                    UserManager.shared.fetchUserInfo(uid: friend) {
//
//                        result in
//
//                        switch result {
//
//                        case .success(let friends):
//
//                            self.friendInfo[friend] = friends
//
//                            group.leave()
//
//                        case .failure(let error):
//
//                            print("fetcFriendData.failure: \(error)")
//
//                            group.leave()
//                        }
//                    }
//                }
//
//                group.notify(queue: .main) {
//
//                    tableView.dataSource = self
//
//                    tableView.delegate = self
//
//                    tableView.reloadData()
//                }
//
//            case .failure(let error):
//                print("fetchFriendList.failure: \(error)")
//            }
//        }
//    }
//
//    func unFriend(at index: Int) {
//
//        UserManager.shared.removeFriend(
//            userId: friends[index]) {
//
//                result in
//
//            switch result {
//
//            case .success(let unFriend):
//
////                self.friends.remove(at: index)
//
//                print("remove friend succesfully")
//
//            case .failure(let error):
//
//                print(error)
//            }
//
//                self.tableView.reloadData()
//        }
//    }
    
    // MARK: - UITableView DataSource
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        guard let friendNumberHandler = friendNumberHandler else { return 0 }
//
//        friendNumberHandler(friends.count)
//
//        return friends.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(
//            withIdentifier: CommunityTableViewCell.identifier,
//                    for: indexPath
//                ) as? CommunityTableViewCell else {
//                    fatalError("can not dequeue tableViewCell")
//                }
                
//        let friendId = friends[indexPath.row]
//
//        guard let friendInfo = friendInfo[friendId] else {
//            return cell
//        }
//
//        cell.layoutCell(
//            name: friendInfo.displayName ?? "",
//            email: friendInfo.userEmail ?? "")
//
//        cell.touchHandler = { [weak self] in
//
//            self?.unFriend(at: indexPath.row)
//
//            self?.blocks.append(self?.friends[indexPath.row] ?? "")
//
//            self?.friends.remove(at: indexPath.row)
//        }
                
//        return cell
//    }
    
//    func tableView(_ tableView: UITableView,
//                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
//    -> UISwipeActionsConfiguration? {
//
//        let onRemove = UIContextualAction(style: .normal, title: "") { (action, view, completionHandler) in
//
//            completionHandler(true)
//        }
//
//        onRemove.backgroundColor = .G1
//
//        onRemove.image = .asset(.icon_cross_yellow)
//
//        let friendId = friends[indexPath.row]
//        UserManager.shared.removeFriend(userId: friendId) { result in
//
//            switch result {
//
//            case .success(let unFriend):
//
//                print("remove friend succesfully")
//
//            case .failure(let error):
//
//                print(error)
//            }
//        }
//
//        return UISwipeActionsConfiguration(actions: [onRemove])
//    }
//}

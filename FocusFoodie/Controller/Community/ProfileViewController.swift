//
//  ProfileViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/5.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProfileViewController: BaseViewController,
                             UITableViewDataSource,
                             UITableViewDelegate {
    
    @IBOutlet weak var profileBackground: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var profileTableView: UITableView! {
        
        didSet {
            
            profileTableView.dataSource = self

            profileTableView.delegate = self
        }
    }
    
    lazy var logoutButton: UIButton = {
        
        let button = UIButton()
        
        let myAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.regular(size: 14),
        ]
        let myAttributeString = NSAttributedString(string: "Log out", attributes: myAttribute)
        
        button.backgroundColor = UIColor.G1
        
        button.tintColor = UIColor.white
        
        button.layer.cornerRadius = 10
        
        button.setTitle("Sign out", for: .normal)
        
        button.titleLabel?.attributedText = myAttributeString
        
        button.layoutIfNeeded()
        
        button.addTarget(self, action: #selector(logOutAction(_:)), for: .touchUpInside)
        return button
    }()
    
    var imageUrl = String()
    
    let storage = Storage.storage().reference()
    
    private let datas: [ProfileCellType] = [.profileInfo, .appSecurity, .appAlert, .appAppearance, .profileSignOut, .profileDeletion, .appVersion]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogoutButton()
        
        navigationController?.setupBackButton(color: .G3!)
    }
    
    override func viewDidLayoutSubviews() {
        
        setupLogoutButton()
    }
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        
        showImagePickerControllerActionSheet()
    }
    
    @objc func logOutAction(_ sender: UIButton) {
        
        let controller = UIAlertController(title: nil, message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            
            do {
                
                try Auth.auth().signOut()
                
                guard let authVC = UIStoryboard.auth.instantiateViewController(
                    withIdentifier: String(describing: AuthViewController.identifier))
                        as? AuthViewController else { return }
                
                authVC.modalPresentationStyle = .fullScreen
                
                self.present(authVC, animated: true, completion: nil)
                
                print("logout")
                
            } catch let signOutError as NSError {
                
                print("Error signing out: \(signOutError)")
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        controller.addAction(okAction)
        
        controller.addAction(cancelAction)
        
        present(controller, animated: true, completion: nil)
    }
    
    private func setupLogoutButton() {
        
        view.addSubview(logoutButton)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            logoutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpTableView() {
        
        profileTableView.registerCellWithNib(identifier: String(describing: ProfileInfoCell.self),
                                             bundle: nil)
        
        profileTableView.registerCellWithNib(identifier: String(describing: ProfileSelectionCell.self),
                                             bundle: nil)
        
        profileTableView.register(
            ProfileButtonCell.self,
            forCellReuseIdentifier: ProfileCellType.profileSignOut.identifier()
        )
        
        profileTableView.register(
            ProfileButtonCell.self,
            forCellReuseIdentifier: ProfileCellType.profileDeletion.identifier()
        )

        profileTableView.register(
            ProfileLabelCell.self,
            forCellReuseIdentifier: ProfileCellType.appVersion.identifier()
        )
    }
    
    // MARK: - UITableView Datasource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoCell.identifier, for: indexPath) as? ProfileInfoCell else {  fatalError() }
        
//        guard let profile = profile else { return UITableViewCell() }
//
//        return datas[indexPath.row].cellForIndexPath(indexPath, tableView: tableView, data: profile)
        
        return cell
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate {
    
    func showImagePickerControllerActionSheet() {
        
        let actionSheet = UIAlertController(title: "Attach Photo", message: "where would you like to attach a photo from", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            
            let picker = UIImagePickerController()
            
            picker.sourceType = .camera
            
            picker.delegate = self
            
            picker.allowsEditing = true
            
            self?.present(picker, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] _ in
            
            let picker = UIImagePickerController()
            
            picker.sourceType = .photoLibrary
            
            picker.delegate = self
            
            picker.allowsEditing = true
            
            self?.present(picker, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        
        profileImage.image = editedImage
        
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        profileImage.image = originalImage
        
        guard let imageData = editedImage.jpegData(compressionQuality: 0.25) else {
            return
        }
        
        let uniqueString = NSUUID().uuidString
        
        storage.child("image/\(uniqueString)").putData(imageData, metadata: nil) { _, error in
            guard error == nil else {
                
                print("Failed to upload")
                
                return
            }
            
            self.storage.child("image/\(uniqueString)").downloadURL(completion: { url, error in
                guard let url = url, error == nil else { return }
                
                let urlString = url.absoluteString
                
                print("Download URL: \(urlString)")
                
                self.imageUrl = urlString
                
                UserDefaults.standard.set(urlString, forKey: "url")
            })
        }
    }
}



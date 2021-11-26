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

private enum ProfileCellType: String {
    
    case profileInfo = ""
    
    case appSecurity = "BIOMETIRC PASSCODE"
    
    case appAlert = "COUNTDOWN ALERT"
    
    case appAppearance = "DARK MODE COMING SOON"
    
    case profileSignOut = "SIGN OUT"
    
    case profileDeletion = "DELETE ACCOUNT"
    
    case appVersion = "1.0.0"
    
    var identifier: String {
        
        switch self {
            
        case .profileInfo:
            
            return String(describing: ProfileInfoCell.self)
            
        case .appSecurity, .appAlert, .appAppearance:
            
            return String(describing: ProfileSelectionCell.self)
            
        case .profileSignOut, .profileDeletion:
            
            return String(describing: ProfileButtonCell.self)
            
        case .appVersion:
            
            return String(describing: ProfileLabelCell.self)
        }
    }
}

class ProfileViewController: BaseViewController,
                             UITableViewDataSource,
                             UITableViewDelegate {
    
    @IBOutlet weak var profileBackground: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var profileTableView: UITableView! {
        
        didSet {
            
            profileTableView.showsVerticalScrollIndicator = false
            
            profileTableView.dataSource = self
            
            profileTableView.delegate = self
        }
    }
    
    @IBOutlet weak var logOutButton: UIButton! {
        
        didSet {
            
            logOutButton.layer.cornerRadius = 10
        }
    }
    
    var imageUrl = String()
    
    let storage = Storage.storage().reference()
    
    private let datas: [ProfileCellType] = [
        .profileInfo,
        .appSecurity, .appAlert,
        .appAppearance,
        .profileSignOut, .profileDeletion,
        .appVersion]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setupBackButton(color: .G3!)
        
        setUpTableView()
    }
    
    @IBAction func onLogOut(_ sender: UIButton) {
        
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
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        
        showImagePickerControllerActionSheet()
    }
    
    private func setUpTableView() {
        
        profileTableView.registerCellWithNib(
            identifier: String(describing: ProfileInfoCell.self),
            bundle: nil)
        
        profileTableView.registerCellWithNib(
            identifier: String(describing: ProfileSelectionCell.self),
            bundle: nil)
        
        profileTableView.register(
            ProfileButtonCell.self,
            forCellReuseIdentifier: ProfileCellType.profileSignOut.identifier
        )
        
        profileTableView.register(
            ProfileButtonCell.self,
            forCellReuseIdentifier: ProfileCellType.profileDeletion.identifier
        )
        
        profileTableView.register(
            ProfileLabelCell.self,
            forCellReuseIdentifier: ProfileCellType.appVersion.identifier
        )
    }
    
    // MARK: - UITableView Datasource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: datas[indexPath.row].identifier, for: indexPath)
        
        return cell
        
//        switch indexPath.row {
//
//        case 0:
//
//            guard let infoCell = profileTableView.dequeueReusableCell(
//                withIdentifier: String(describing: ProfileInfoCell.self),
//                for: indexPath) as? ProfileInfoCell else { fatalError() }
//
//            infoCell.layoutCellWithInfo(
//                name: "Allie",
//                email: "theallietang@gmail.com")
//
//            return infoCell
//
//        case 1:
//
//            guard let alertCell = profileTableView.dequeueReusableCell(
//                withIdentifier: String(describing: ProfileSelectionCell.self),
//                for: indexPath) as? ProfileSelectionCell else { fatalError() }
//
//            alertCell.layoutCellWithSwitch(
//                status: true,
//                category: "COUNTDOWN ALERT",
//                image: UIImage.asset(.icon_fingerprint))
//
//            return alertCell
//
//        case 2:
//
//            guard let labelCell = profileTableView.dequeueReusableCell(
//                withIdentifier: String(describing: ProfileLabelCell.self),
//                for: indexPath) as? ProfileLabelCell else { fatalError() }
//
//            labelCell.layoutCellWithLabel(
//                content: "1.0.0")
//
//            return labelCell
//
//        default:
//            break
//        }
//
//        return UITableViewCell()
    }
    
    // MARK: - UITableView Delegate -
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            return 200
            
        } else {
            
            return 150
        }        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        UITableView.automaticDimension
    }
}

// MARK: - Photo Library & Camera -

extension ProfileViewController: UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate {
    
    func showImagePickerControllerActionSheet() {
        
        let actionSheet = UIAlertController(
            title: "Attach Photo",
            message: "where would you like to attach a photo from",
            preferredStyle: .actionSheet)
        
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



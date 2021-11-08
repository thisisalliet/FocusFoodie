//
//  ProfileViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/5.
//

import UIKit
import FirebaseAuth

class ProfileViewController: BaseViewController {
        
    lazy var logoutButton: UIButton = {
        
        let button = UIButton()
        
        let myAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.regular(size: 14),
        ]
        let myAttributeString = NSAttributedString(string: "Log out", attributes: myAttribute)
        
        button.backgroundColor = UIColor.B1
        
        button.tintColor = UIColor.white
        
        button.layer.cornerRadius = 10
        
        button.setTitle("登出", for: .normal)
        
        button.titleLabel?.attributedText = myAttributeString
        
        button.layoutIfNeeded()
        
        button.addTarget(self, action: #selector(logOutAction(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogoutButton()
    }
    
    override func viewDidLayoutSubviews() {
        
        setupLogoutButton()
    }
    
    @objc func logOutAction(_ sender: UIButton) {
        
        let controller = UIAlertController(title: nil, message: "確定要登出嗎?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "確定", style: .default) { _ in
            
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
    
    // MARK: UI design
    
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
}

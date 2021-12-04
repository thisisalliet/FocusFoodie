//
//  AuthViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/5.
//

import UIKit
import CryptoKit
import FirebaseAuth
import FirebaseFirestore
import AuthenticationServices

class AuthViewController: BaseViewController {
    
    fileprivate var currentNonce: String?
    
    var handle: AuthStateDidChangeListenerHandle?
    
    weak var sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    
    @IBOutlet weak var appIconImage: UIImageView!
    
    @IBOutlet weak var noticeLabel: UILabel!
    
    @IBOutlet weak var privacyPolicyButton: UIButton!
    
    func configure() {
        
        appIconImage.image = UIImage.asset(.icon_appLogo)
        
        appIconImage.alpha = 0.75
    }
    
    @IBAction func privacyPolicyButtonTapped(_ sender: UIButton) {
        
        guard UIStoryboard
                .auth
                .instantiateViewController(
                    withIdentifier: String(describing: PrivacyViewController.self)
                ) is PrivacyViewController else {
                    
                    return
                }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        configure()
        
        setUpSignInButton()
        
        performSignIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        
        setUpSignInButton()
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
        configure()
    }
    
    func setUpSignInButton() {
        
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .white)
        
        view.addSubview(button)
        
        button.layer.cornerRadius = 10.0
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: noticeLabel.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: noticeLabel.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 45),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        button.addTarget(self, action: #selector(signInWithAppleTapped), for: .touchUpInside)
    }
    
    @objc func signInWithAppleTapped() {
           
           performSignIn()
       }
    
    func performSignIn() {
        
        let request = createAppleIdRequest()
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
    }
    
    func createAppleIdRequest() -> ASAuthorizationAppleIDRequest {
        
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        
        let request = appleIdProvider.createRequest()
        
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
        
        request.nonce = sha256(nonce)
        
        currentNonce = nonce
        
        return request
    }
    
    private func sha256(_ input: String) -> String {
        
        let inputData = Data(input.utf8)
        
        let hashedData = SHA256.hash(data: inputData)
        
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

extension AuthViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let nonce = currentNonce else {
                
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            guard let appleIdToken = appleIdCredential.identityToken else {
                
                print("Unable to fetch identity token")
                return
            }
            
            guard let idTokenString = String(data: appleIdToken, encoding: .utf8) else {
                
                print("Unable to serialize token string from data: \(appleIdToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // sign in with Firebase
            Auth.auth().signIn(with: credential) { (authResult, error) in
                
                if let error = error {
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    print("Sign-in Failed")
                    print(error.localizedDescription)
                    return
                }
                
                if let user = authResult?.user {
                    print("Nice! You are now signed in as \(user.uid), email: \(String(describing: user.email))")
                    
                    if let fullName = appleIdCredential.fullName,
                       let userName = fullName.givenName {
                        
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        
                        changeRequest?.displayName = userName
                        changeRequest?.commitChanges { _ in
                            // ...
                        }
                    }
                    
                    UserManager.shared.createUserInfo()
                    
                    guard let window = self.sceneDelegate?.window else {
                        fatalError("Cannot get window")
                    }
                    
                    guard let tabBarVC = UIStoryboard
                            .main
                            .instantiateViewController(
                                withIdentifier: String(describing: TabBarViewController.self)
                            ) as? TabBarViewController else {
                                
                                return
                            }
                    
                    window.rootViewController = tabBarVC
                }
            }
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            
            print("Sign in with Apple errored: \(error)")
        }
    }
}

extension AuthViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return self.view.window!
    }
}

private func randomNonceString(length: Int = 32) -> String {
    
    precondition(length > 0)
    
    let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    
    var result = ""
    
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError(
                    "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                )
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    return result
}

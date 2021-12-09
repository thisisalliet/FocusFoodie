//
//  EndingViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/17.
//

import UIKit

class EndingViewController: BaseViewController {
    
    enum BreadType: String {
        
        case toast = "Toast"
        
        case burgerBun = "Bun"
        
        case baguette = "Baguette"
        
        case croissant = "Croissant"
        
        case flatBread = "FlatBread"
    }
    
    private struct Segue {

        static let toast = "SegueToast"

        static let burgerBun = "SegueBurgerBun"

        static let baguette = "SegueBaguette"
        
        static let croissant = "SegueCroissant"

        static let flatBread = "SegueFlatBread"

    }
    
    @IBOutlet weak var blurView: UIView! {
        
        didSet {
            
            blurView.alpha = 0.5
        }
    }
    
    @IBOutlet weak var dissmissButton: UIButton! {
        
        didSet {
            
            dissmissButton.cornerRadius = dissmissButton.frame.width / 2
        }
    }
    
    @IBOutlet weak var toastContainerView: UIView!
    
    @IBOutlet weak var bunContainerView: UIView!
    
    @IBOutlet weak var baguetteContainerView: UIView!
    
    @IBOutlet weak var croissantContainerView: UIView!
    
    @IBOutlet weak var flatBreadContainerView: UIView!
    
    var containerViews: [UIView] {

        return [toastContainerView, bunContainerView, baguetteContainerView, croissantContainerView, flatBreadContainerView]
    }
    
    var vegetableItem = ""

    var meatItem = ""
    
    var sideItem = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onDismiss(_ sender: UIButton) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let identifier = segue.identifier
        
        if identifier == Segue.toast,
           let toastVC = segue.destination as? ToastViewController {
            
            toastVC.vegetableImage.image = VegetableItem(rawValue: vegetableItem)?.image
            
            toastVC.meatImage.image = MeatItem(rawValue: meatItem)?.image

            toastVC.sideimage.image = MeatItem(rawValue: sideItem)?.image

        } else if identifier == Segue.burgerBun,
                  let bunVC = segue.destination as? ToastViewController {
            
//            invitationVC.invitationNumberHandler = { [weak self] number in
//
//                guard let strongself = self else { return }
//
//                strongself.invitationNumber.text = "\(number)"
//            }
//
//            invitationVC.monitorInvitation()

        } else if identifier == Segue.baguette,
                  let baguetteVC = segue.destination as? ToastViewController {
            
//            blockVC.blockNumberHandler = { [weak self] number in
//
//                guard let strongSelf = self else { return }
//
//                strongSelf.blockNumber.text = "\(number)"
//            }
//
//            blockVC.monitorBlockList()
//
//            self.blockVC = blockVC
        } else if identifier == Segue.croissant,
                  let croissantVC = segue.destination as? ToastViewController {
            
            
        } else if  identifier == Segue.flatBread,
                   let flatBreadVC = segue.destination as? ToastViewController {
            
        }
    }
        
    func updateContainer(type: BreadType) {
        
        containerViews.forEach ({ $0.isHidden = true })
        
        switch type {
            
        case .toast:
            
            toastContainerView.isHidden = false
            
        case .burgerBun:
            
            bunContainerView.isHidden = false
            
        case .baguette:
            
            baguetteContainerView.isHidden = false
            
        case .flatBread:
            
            flatBreadContainerView.isHidden = false
            
        case .croissant:
            
            croissantContainerView.isHidden = false
        }
    }
}

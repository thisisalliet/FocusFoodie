//
//  EndingViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/17.
//

import UIKit

class EndingViewController: BaseViewController {
    
    @IBOutlet weak var blurView: UIView! {
        
        didSet {
            
            blurView.alpha = 0.5
        }
    }
    
    @IBOutlet weak var endingImage: UIView! {
        
        didSet {
            
            endingImage.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var dissmissButton: UIButton! {
        
        didSet {
            
            dissmissButton.cornerRadius = dissmissButton.frame.width / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onDismiss(_ sender: UIButton) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

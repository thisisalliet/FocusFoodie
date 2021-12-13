//
//  EndingViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/17.
//

import UIKit

class EndingViewController: BaseViewController {
        
    @IBOutlet weak var blurView: UIView!
    
    @IBOutlet weak var endingImageView: ToastView!
    
    @IBOutlet weak var endMessageBackground: UIView!
    
    @IBOutlet weak var endMessageLabel: UILabel!
    
    @IBOutlet weak var dissmissButton: UIButton!
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let recipe = recipe else {
            return
        }
        
        endingImageView.layoutView(recipe: recipe)
        
        configure()
    }
    
    // MARK: - Button Action -
    
    @IBAction func onDismiss(_ sender: UIButton) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Method -
    
    private func configure() {
        
        blurView.alpha = 0.5
        
        endingImageView.roundCornersOnTop(cornerRadius: 20.0)

        endMessageBackground.roundCornersAtBottom(cornerRadius: 20.0)

        dissmissButton.cornerRadius = dissmissButton.frame.width / 2
    }
}

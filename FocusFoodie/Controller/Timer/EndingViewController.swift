//
//  EndingViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/17.
//

import UIKit

class EndingViewController: BaseViewController {
    
    @IBOutlet weak var blurView: UIView!
    
    @IBOutlet weak var endingImage: UIView! {
        
        didSet {
            
            endingImage.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var hungryButton: UIButton! {
        
        didSet {
            
            hungryButton.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var fullButton: UIButton! {
        
        didSet {
            
            fullButton.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onHungry(_ sender: UIButton) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onFull(_ sender: UIButton) {
        
        guard let recordVC = UIStoryboard.record.instantiateViewController(
            withIdentifier: String(describing: RecordViewController.identifier))
                as? RecordViewController else { return }
        
        recordVC.modalPresentationStyle = .fullScreen
        
        self.present(recordVC, animated: true, completion: nil)
    }
    
}

//
//  RecordViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit

class RecordViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    private struct Segue {

        static let picker = "SeguePicker"
    }
    
    @IBOutlet weak var recordTableView: UITableView! {
        
        didSet {
            
            recordTableView.dataSource = self
            
            recordTableView.delegate = self
        }
    }
    
    @IBOutlet weak var profileView: ProfileView! {
        
        didSet {
            
            profileView.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var calendarPickerView: UIView!
    
    @IBOutlet weak var calendarButton: UIButton! {
        
        didSet {
            
            calendarButton.backgroundColor = .B2
            
            calendarButton.setTitleColor(.B5, for: .normal)
        }
    }
    
    @IBOutlet weak var baseView: UIView!
    
    var pickerViewController: CalendarPickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    private func setUpTableView() {
        
        recordTableView.registerCellWithNib(identifier:
            String(describing: RecordTableViewCell.self),
                                            bundle: nil
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == Segue.picker,
           let pickerVC = segue.destination as? CalendarPickerViewController {

//            pickerVC.delegate = self

//            pickerVC.product = product

            pickerViewController = pickerVC
        }
    }
    
    // MARK: - Action
    @IBAction func didTouchCalendarBtn(_ sender: UIButton) {
        
//        if calendarPickerView.superview == nil {

            showCalendarPickerView()

//        } else {
//
//            guard let color = pickerViewController?.selectedColor,
//                  let size = pickerViewController?.selectedSize,
//                  let amount = pickerViewController?.selectedAmount,
//                  let product = product
//            else { return }
//
//            StorageManager.shared.saveOrder(
//                color: color, size: size, amount: amount, product: product,
//                completion: { result in
//
//                    switch result {
//
//                    case .success:
//
//                        LKProgressHUD.showSuccess()
//
//                        dismissPicker(pickerViewController!)
//
//                    case .failure:
//
//                        LKProgressHUD.showFailure(text: "儲存失敗！")
//                    }
//                })
//        }
    }
    
    func showCalendarPickerView() {

        let maxY = recordTableView.frame.maxY
        
        calendarPickerView.frame = CGRect(
            x: 0,
            y: maxY,
            width: UIScreen.width,
            height: 0.0
        )
        
        baseView.insertSubview(calendarPickerView, belowSubview: calendarButton.superview!)

//        baseView.insertSubview(blurView, belowSubview: calendarPickerView)

        UIView.animate(
            withDuration: 0.3,
            animations: { [weak self] in

                guard let strongSelf = self else { return }

                let height =
                451.0 / 586.0 * strongSelf.recordTableView.frame.height
                
                self?.calendarPickerView.frame = CGRect(
                    x: 0,
                    y: maxY - height,
                    width: UIScreen.width,
                    height: height
                )

            }
        )
    }
    
    // MARK: - UITableViewDataSource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = recordTableView.dequeueReusableCell(
            withIdentifier: String(describing: RecordTableViewCell.self),
            for: indexPath
        )
        
        guard let cell = cell as? RecordTableViewCell else { return cell }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let detailVC = UIStoryboard
            .record
            .instantiateViewController(
                withIdentifier: String(describing: DetailViewController.self)
            ) as? DetailViewController else {
                
                return
        }
        
//        detailVC.product = datas[indexPath.section].products[indexPath.row]
        
        show(detailVC, sender: nil)
    }
    
    // MARK: - UITableViewDelegate -

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

//
//  CompoundViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/14.
//

import UIKit

class CompoundViewController: BaseViewController,
                            UITableViewDataSource,
                            UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        tableView.beginHeaderRefreshing()
    }
    
    // MARK: - Private Method
    
    private func setupTableView() {

        if tableView == nil {

            let tableView = UITableView()

            view.stickSubView(tableView)

            self.tableView = tableView
        }

        tableView.addRefreshHeader(refreshingBlock: { [weak self] in

            self?.headerLoader()
        })

        tableView.addRefreshFooter(refreshingBlock: { [weak self] in

            self?.footerLoader()
        })
    }
    
    // MARK: - Public Method -
    
    func reloadData() {

        guard Thread.isMainThread == true else {

            DispatchQueue.main.async { [weak self] in

                self?.reloadData()
            }

            return
        }

        tableView.reloadData()
    }
    
    func headerLoader() {

        tableView.endHeaderRefreshing()
    }

    func footerLoader() {

        tableView.endFooterRefreshing()
    }

    func endHeaderRefreshing() {

        tableView.endHeaderRefreshing()
    }

    func endFooterRefreshing() {

        tableView.endFooterRefreshing()
    }

    func endWithNoMoreData() {

        tableView.endWithNoMoreData()
    }

    func resetNoMoreData() {

        tableView.resetNoMoreData()
    }

    // MARK: - UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell(style: .default, reuseIdentifier: String(describing: CompoundViewController.self))
    }
    
    // MARK: - UITabelview Delegate -
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

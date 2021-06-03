//
//  UserDetailViewController.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 01/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import UIKit

protocol UserDetailViewControllerDelegate: class {
    func viewDidClose(sender: UserDetailViewController)
}
class UserDetailViewController: UIViewController {

    var model: Model {
        didSet {
            applyModel()
        }
    }
    private var loadingIndicator = UIActivityIndicatorView()
    private var tableView: UITableView?
    weak var delegate: UserDetailViewControllerDelegate?

    init(model: Model = .init()) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        applyModel()
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        tableView = UITableView()
        self.view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        delegate?.viewDidClose(sender: self)
    }

    private func applyModel() {
        if model.isEmpty() {
            showLoadingIndicator()
        } else {
            hideLoadingIndicator()
            self.title = model.userName
        }
    }

    private func setUpView() {
        self.view.addAutoLayoutSubView(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }

    private func showLoadingIndicator() {
        tableView?.isHidden = true
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }

    private func hideLoadingIndicator() {
        tableView?.isHidden = false
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
    }

}

//
//  ViewController.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 30/05/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    var model: Model {
        didSet {
            applyModel()
        }
    }
    var sections: [CellDisplayable] = []
    weak var coordinator: Coordinator?
    private var tableView: UITableView?
    private var loadingIndicator = UIActivityIndicatorView()

    init(model: UserListViewController.Model = .init()) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        applyModel()
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("view is loaded")
    }

    override func loadView() {
        tableView = UITableView()
        tableView?.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.id)
        tableView?.dataSource = self
        tableView?.estimatedRowHeight = 180
        tableView?.separatorStyle = .none
        tableView?.allowsSelection = false
        self.view = tableView
    }

    private func setUp() {
        self.view.addAutoLayoutSubView(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }

    func applyModel() {
        self.title = "GitHub Users"
        sections =  model.generateSections()
        if sections.isEmpty {
            showLoadingIndicator()
        } else {
            tableView?.reloadData()
            hideLoadingIndicator()
        }
    }

    func showLoadingIndicator() {
        tableView?.isHidden = true
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }

    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        tableView?.isHidden = false
        loadingIndicator.isHidden = true
    }
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.id, for: indexPath) as? UserTableViewCell else {
            fatalError("error while dequeuing cell")
        }
        cell.attach(cellView: sections[indexPath.row])
        return cell
    }
}

//
//  ViewController.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 30/05/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import UIKit

protocol UserListViewControllerDelegate: AnyObject {
    func didSelectUser(_ user: UserContext, sender: UserListViewController)
}

class UserListViewController: UIViewController {

    var model: ModelViewState = .ready {
        didSet {
            applyModel()
        }
    }
    private var sections: [CellDisplayable] = []
    weak var delegate: UserListViewControllerDelegate?
    private var tableView: UITableView?
    private var loadingIndicator = UIActivityIndicatorView()

    init() {
        super.init(nibName: nil, bundle: nil)
        applyModel()
        setUpView()
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
        tableView?.delegate = self
        tableView?.estimatedRowHeight = 180
        tableView?.separatorStyle = .none
        self.view = tableView
    }

    private func setUpView() {
        self.view.addAutoLayoutSubView(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }

    func applyModel() {
        switch model {
        case .ready:
            break
        case .loading:
            showLoadingIndicator()
        case .completed(let result):
            hideLoadingIndicator()
            switch result {
            case .success(let model):
                self.title = model.title
                sections =  model.generateSections()
                tableView?.reloadData()
            case .failure(let error):
                print("TODO: Handle error state, API error occured: \(error)")
            }
        }
    }

    func showLoadingIndicator() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }

    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.id, for: indexPath) as? UserTableViewCell else {
            fatalError("error while dequeuing cell")
        }
        cell.selectionStyle = .none
        cell.attach(cellView: sections[indexPath.row])
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = model.cellModels[indexPath.row]
        if let url = cellModel.url {
            delegate?.didSelectUser(.init(id: cellModel.id, url: url), sender: self)
        }
    }
}

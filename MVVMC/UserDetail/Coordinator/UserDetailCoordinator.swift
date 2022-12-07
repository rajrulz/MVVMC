//
//  UserDetailCoordinator.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 01/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation
import UIKit
import Combine

class UserDetailCoordinator: Coordinator<Void> {
    private var navigationController: UINavigationController
    private var userDetailsService: UserDetailService
    private var userContext: UserContext
    private var viewController: UserDetailViewController
    private var cancellableSubscribers = Set<AnyCancellable>()

    init(userContext: UserContext,
         navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.userDetailsService = UserDetailServiceClient()
        self.userContext = userContext
        self.viewController = UserDetailViewController()
        super.init()
        self.viewController.delegate = self
    }

    override func start() {
        super.start()
        self.navigationController.navigationBar.prefersLargeTitles = false
        navigationController.pushViewController(viewController, animated: true)
        viewController.model = .loading
        userDetailsService.userDetails(for: .init(url: userContext.url))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.viewController.model = .completed(.failure(error))
                case .finished:
                    print("Subsciption finished")
                }
            }) { [weak self] in
                self?.viewController.model = .completed(.success(.init(userDetail: $0.data)))
            }
            .store(in: &cancellableSubscribers)
    }
}
extension UserDetailCoordinator: UserDetailViewControllerDelegate {
    func viewDidClose(sender: UserDetailViewController) {
        navigationController.navigationBar.prefersLargeTitles = true
        finish(())
    }
}

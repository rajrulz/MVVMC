//
//  UserDetailPluginAPI.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 27/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation
import UIKit

class UserDetailPluginAPI: UserDetailAPI {
    func getUserDetailsCoordinator(context: UserContext, navigationController: UINavigationController) -> Coordinator<Void> {
        return UserDetailCoordinator(userContext: context,
                                     navigationController: navigationController)
    }
}

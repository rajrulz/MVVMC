//
//  ItemAPI.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 27/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation
import UIKit

public struct UserContext {
    public var id: Int
    public var url: URL
}

protocol PluginAPI {
    init(_ container: Container)
}
protocol UserDetailAPI: PluginAPI {
    func getUserDetailsCoordinator(context: UserContext, navigationController: UINavigationController) -> Coordinator<Void>
}


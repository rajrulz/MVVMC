//
//  UserCellView+Model.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 31/05/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation

extension UserCellView {
    struct Model {
        var avatarUrl: String
        var type: String
        var username: String
        var id: Int
        var url: URL?

        init(user: User) {
            self.username = user.login ?? ""
            self.type = user.type ?? ""
            self.avatarUrl = user.avatarURL ?? ""
            self.id = user.id ?? 0
            if let url = user.url {
                self.url = URL(string: url) ?? nil
            }
        }
    }
}

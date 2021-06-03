//
//  UserDetailViewController+Model.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 01/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation

extension UserDetailViewController {
    struct Model {
        var userName: String = ""
        var id: Int = 0
        var name: String = ""
        var followers: Int = 0
        var following: Int = 0
        var followersURL: URL?
        var followingURL: URL?
        var type: String = ""
        var company: String = ""
        var blog: URL?
        var avatarURL: URL?

        init() { }

        init(userDetail: UserDetail) {
            self.userName = userDetail.login ?? ""
            self.id = userDetail.id ?? 0
            self.name = userDetail.name ?? ""
            self.followers = userDetail.followers ?? 0
            self.following = userDetail.following ?? 0
            self.type = userDetail.type ?? ""
            self.company = userDetail.company ?? ""
            if let followersURL = userDetail.followersURL {
                self.followersURL = URL(string: followersURL) ?? nil
            }
            if let followingURL = userDetail.followingURL {
                self.followingURL = URL(string: followingURL) ?? nil
            }
            if let avatarURL = userDetail.avatarURL {
                self.followingURL = URL(string: avatarURL) ?? nil
            }
            if let blogURL = userDetail.blog {
                self.blog = URL(string: blogURL) ?? nil
            }
        }

        func isEmpty() -> Bool {
            return self.id == 0
        }
    }
}

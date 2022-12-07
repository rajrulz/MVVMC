//
//  UserDetailViewController+Model.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 01/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation

extension UserDetailViewController {

    enum ModelViewState {
        case ready
        case loading
        case completed(Result<Model, Error>)
    }

    struct Model {
        private var userName: String = ""
        private var id: Int = 0
        private var name: String = ""
        private var followers: Int = 0
        private var following: Int = 0
        private var followersURL: URL?
        private var followingURL: URL?
        private var type: String = ""
        private var company: String = ""
        private var blog: String = ""
        private var avatarURL: String = ""
        private var email: String = ""
        private var twitterUserName: String = ""
        private var bio: String = ""
        private var location: String = ""
        var screenTitle: String = ""

        init(userDetail: UserDetail) {
            self.userName = userDetail.login ?? ""
            self.id = userDetail.id ?? 0
            self.name = userDetail.name ?? ""
            self.followers = userDetail.followers ?? 0
            self.following = userDetail.following ?? 0
            self.type = userDetail.type ?? ""
            self.company = userDetail.company ?? ""
            self.avatarURL = userDetail.avatarURL ?? ""
            if let followersURL = userDetail.followersURL {
                self.followersURL = URL(string: followersURL) ?? nil
            }
            if let followingURL = userDetail.followingURL {
                self.followingURL = URL(string: followingURL) ?? nil
            }
            self.blog = userDetail.blog ?? ""
            self.email = userDetail.email ?? ""
            self.bio = userDetail.bio ?? ""
            self.location = userDetail.location ?? ""
            self.twitterUserName = userDetail.twitterUsername ?? ""
            screenTitle = self.userName
        }

        func isEmpty() -> Bool {
            return self.id == 0
        }

        func generateSections() -> [CellDisplayable] {
            return [
                UserImageView(model: .init(imageUrlStr: avatarURL)),
                FollowersCellView(model: .init(followers: followers,
                                               following: following,
                                               followersURL: followersURL,
                                               followingURL: followingURL)),
                UserDetailsView(model: .init(name: name,
                                             company: company,
                                             blog: blog,
                                             email: email,
                                             location: location,
                                             twitterUsername: twitterUserName,
                                             bio: bio))
            ]
        }
    }
}

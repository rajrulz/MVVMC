//
//  UserListViewController+Model.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 31/05/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation

extension UserListViewController {
    struct Model {
        var title: String
        var cellModels: [UserCellView.Model]

        init(response: UserService.Response = .init(data: []), title: String = "") {
            self.cellModels = response.data.map { UserCellView.Model(user: $0) }
            self.title = title
        }

        func generateSections() -> [CellDisplayable] {
            return cellModels.map { UserCellView(model: $0) }
        }
    }
}

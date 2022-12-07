//
//  UserListViewController+Model.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 31/05/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation

extension UserListViewController {
    enum ViewState {
        case loading
        case loaded
    }

    struct Model {
        var state: ViewState
        var title: String
        var cellModels: [UserCellView.Model]

        init(state: ViewState, response: UserService.Response = .init(data: []), title: String = "") {
            self.cellModels = response.data.map { UserCellView.Model(user: $0) }
            self.title = title
            self.state = state
        }

        func generateSections() -> [CellDisplayable] {
            return cellModels.map { UserCellView(model: $0) }
        }
    }
}

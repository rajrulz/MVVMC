//
//  UserDetailTableViewCell.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 04/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {
    static let id = "UserDetailTableViewCell"

    func attach(cellView: CellDisplayable) {
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let displayView = cellView.getView()
        contentView.addAutoLayoutSubView(displayView)
        displayView.backgroundColor = #colorLiteral(red: 0.8874396375, green: 0.8874396375, blue: 0.8874396375, alpha: 1)
        displayView.layer.cornerRadius = Spacing.small
                NSLayoutConstraint.activate([
            displayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.small),
            displayView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.small),
            displayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.small),
            displayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    override func prepareForReuse() {
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        super.prepareForReuse()
    }
}

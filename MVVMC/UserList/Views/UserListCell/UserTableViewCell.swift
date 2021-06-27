//
//  UserTableViewCell.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 31/05/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    static let id = "UserTableViewCell"

    func attach(cellView: CellDisplayable) {
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let displayView = cellView.getView()
        contentView.addAutoLayoutSubView(displayView)
        displayView.layer.cornerRadius = Spacing.small

        NSLayoutConstraint.activate([
            displayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.small),
            displayView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.small),
            displayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.small),
            displayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
    }
}

extension UIView {
    func addAutoLayoutSubView(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

enum Spacing {
    static let small = CGFloat(16.0)
    static let vSmall = CGFloat(8.0)
    static let medium = CGFloat(32.0)
    static let large = CGFloat(64.0)
}

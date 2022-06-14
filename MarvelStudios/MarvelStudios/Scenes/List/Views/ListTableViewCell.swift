//
//  ListCellTableViewCell.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 13/6/22.
//  Copyright © 2022 MynSoftware. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    static var cellIdentifier: String {
        String(describing: ListTableViewCell.self)
    }
    
    var title: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        accessoryType = .disclosureIndicator
    }
    
    func updateUI(item: List.CharacterViewModel) {
        title.text = item.name
    }

}

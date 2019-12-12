//
//  FriendsListTableViewCell.swift
//  FriendsListVK
//
//  Created by Иван Бабушкин on 11.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

class FriendsListTableViewCell: UITableViewCell {
    
    static let reuseId = "FriendsListTableViewCell"
    
    let photoImage: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.5019607843, blue: 0.7607843137, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    override func prepareForReuse() {
        photoImage.set(imageURL: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        photoImage.layer.cornerRadius = 20
        photoImage.clipsToBounds = true
        setUpCell()
    }
    
    func set(viewModel: FriendsCellViewModel) {
        photoImage.set(imageURL: viewModel.photo50UrlString)
        nameLabel.text = viewModel.firstName + " " + viewModel.lastName
    }
    
    // MARK: - Set constraints for cell
    
    private func setUpCell() {
        addSubview(photoImage)
        addSubview(nameLabel)
        
        photoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        photoImage.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        photoImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        photoImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        photoImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: photoImage.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: photoImage.trailingAnchor, constant: 8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

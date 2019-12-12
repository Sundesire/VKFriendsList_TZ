//
//  FriendsListPresenter.swift
//  FriendsListVK
//
//  Created by Иван Бабушкин on 11.12.2019.
//  Copyright (c) 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

protocol FriendsListPresentationLogic {
    func presentData(response: FriendsList.Model.Response.ResponseType)
}

class FriendsListPresenter: FriendsListPresentationLogic {
    weak var viewController: FriendsListDisplayLogic?
    
    func presentData(response: FriendsList.Model.Response.ResponseType) {
        switch response {
        case .presentFriends(let friends):
            let cells = friends.items.map { friendItem in
                cellViewModel(from: friendItem)
            }
            let friendsViewModel = FriendsViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayFriends(friendsViewModel: friendsViewModel))
            
        case .presentUserInfo(let user):
            guard let user = user else { return }
            let userViewModel = UserViewModel(firstName: user.firstName, lastName: user.lastName, photo200: user.photo200, friendsCount: user.counters.friends)
            viewController?.displayData(viewModel: .displayUser(userViewModel: userViewModel))
        }
    }
    
    private func cellViewModel(from userItem: FriendItem) -> FriendsViewModel.Cell {
        return FriendsViewModel.Cell(id: "\(userItem.id)", firstName: userItem.firstName, lastName: userItem.lastName, photo50UrlString: userItem.photo50)
    }
    
}

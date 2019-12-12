//
//  FriendsListInteractor.swift
//  FriendsListVK
//
//  Created by Иван Бабушкин on 11.12.2019.
//  Copyright (c) 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

protocol FriendsListBusinessLogic {
    func makeRequest(request: FriendsList.Model.Request.RequestType)
}

class FriendsListInteractor: FriendsListBusinessLogic {
    
    var presenter: FriendsListPresentationLogic?
    var service: FriendsListService?
    
    func makeRequest(request: FriendsList.Model.Request.RequestType) {
        if service == nil {
            service = FriendsListService()
        }
        switch request {
        case .getFriends:
            service?.getFriendsList(completion: {[weak self] (friends) in
                self?.presenter?.presentData(response: .presentFriends(friends: friends))
            })
        case .getUser:
            service?.getUser(completion: {[weak self] (user) in
                self?.presenter?.presentData(response: .presentUserInfo(user: user))
            })
        case .openURL(let id):
            service?.openUrl(id: id)
            
        }
    }
}

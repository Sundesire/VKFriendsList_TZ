//
//  FriendsListModels.swift
//  FriendsListVK
//
//  Created by Иван Бабушкин on 11.12.2019.
//  Copyright (c) 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

enum FriendsList {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getFriends
                case getUser
                case openURL(id: String)
            }
        }
        struct Response {
            enum ResponseType {
                case presentFriends(friends: FriendsResponse)
                case presentUserInfo(user: UserResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayFriends(friendsViewModel: FriendsViewModel)
                case displayUser(userViewModel: UserViewModel)
            }
        }
    }
    
}


struct UserViewModel {
    var firstName: String
    var lastName: String
    var photo200: String?
    var friendsCount: Int
}

protocol FriendsCellViewModel {
    var id: String { get }
    var firstName: String { get }
    var lastName: String { get }
    var photo50UrlString: String? { get }
}

struct FriendsViewModel {
    struct Cell: FriendsCellViewModel {
        var id: String
        var firstName: String
        var lastName: String
        var photo50UrlString: String?
    }
    var cells: [Cell]
}

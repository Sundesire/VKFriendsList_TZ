//
//  UserResponse.swift
//  FriendsListVK
//
//  Created by Иван Бабушкин on 12.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let firstName: String
    let lastName: String
    let photo200: String?
    let counters: Counters
}

struct Counters: Decodable {
    let friends: Int
}

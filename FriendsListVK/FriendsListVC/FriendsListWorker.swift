//
//  FriendsListWorker.swift
//  FriendsListVK
//
//  Created by Иван Бабушкин on 11.12.2019.
//  Copyright (c) 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

class FriendsListService {
    var authService: AuthService
    var networking: NetworkServiceProtocol
    var dataFetcher: NetworkDataFetcherProtocol
    
    private var usersResponse: FriendsResponse?
    
    init() {
        self.authService = AppDelegate.shared().authService
        self.networking = NetworkService(authService: authService)
        self.dataFetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getFriendsList(completion: @escaping (FriendsResponse) -> ()) {
        dataFetcher.getFriendsList { (friendResponse) in
            completion(friendResponse!)
        }
    }
    
    func getUser(completion: @escaping (UserResponse?) -> ()) {
        dataFetcher.getUser { (userResponse) in
            completion(userResponse!)
        }
    }
    
    func openUrl(id: String) {
        guard let url = URL(string: "https://vk.com/id\(id)") else { return }
        UIApplication.shared.open(url)
    }
}

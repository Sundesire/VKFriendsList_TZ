//
//  NetworkDataFetcher.swift
//  FriendsListVK
//
//  Created by Иван Бабушкин on 11.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import Foundation

protocol NetworkDataFetcherProtocol {
    func getFriendsList(response: @escaping (FriendsResponse?) -> ())
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: NetworkDataFetcherProtocol {
    let networking: NetworkServiceProtocol
    private let authService: AuthService
    
    init(networking: NetworkServiceProtocol, authService: AuthService = AppDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
    
    func getFriendsList(response: @escaping (FriendsResponse?) -> ()) {
        let params = ["fields":"id, first_name, last_name, photo_50"]
        networking.request(path: API.getFriendsList, params: params) { (data, error) in
            if let error = error {
                print("Error recieved requested data: \(error.localizedDescription)")
                response(nil)
            }
            let decoder = self.decodeJSON(type: FriendsResponseWrapped.self, from: data)
            response(decoder?.response)
        }
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService.userId else { return }
        let params = ["user_ids": userId,"fields":"first_name, last_name, photo_200, counters"]
        networking.request(path: API.user, params: params) { (data, error) in
            if let error = error {
                print("Error recieved requested data: \(error.localizedDescription)")
                response(nil)
            }
            let decoder = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoder?.response.first)
        }
    }
    
    private func decodeJSON<T: Decodable> (type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil}
        return response
    }
}

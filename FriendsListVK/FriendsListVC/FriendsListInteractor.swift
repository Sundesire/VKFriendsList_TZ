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
  }
  
}

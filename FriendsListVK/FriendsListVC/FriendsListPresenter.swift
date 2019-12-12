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
  
  }
  
}

//
//  FriendsListViewController.swift
//  FriendsListVK
//
//  Created by Иван Бабушкин on 11.12.2019.
//  Copyright (c) 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

protocol FriendsListDisplayLogic: class {
  func displayData(viewModel: FriendsList.Model.ViewModel.ViewModelData)
}

class FriendsListViewController: UIViewController, FriendsListDisplayLogic {

  var interactor: FriendsListBusinessLogic?
  var router: (NSObjectProtocol & FriendsListRoutingLogic)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = FriendsListInteractor()
    let presenter             = FriendsListPresenter()
    let router                = FriendsListRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func displayData(viewModel: FriendsList.Model.ViewModel.ViewModelData) {

  }
  
}

//
//  AuthViewController.swift
//  FriendsListVK
//
//  Created by Иван Бабушкин on 11.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import Foundation
import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    private var authService: AuthService!
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
        authService = AppDelegate.shared().authService
    }
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        authService.wakeUpSession()
    }
}

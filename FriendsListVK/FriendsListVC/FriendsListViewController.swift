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
    private var friendsViewModel = FriendsViewModel(cells: [])
    var userViewModel = UserViewModel(firstName: "", lastName: "", photo200: "", friendsCount: 0)
    @IBOutlet weak var tableView: UITableView!
    
    
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
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendsListTableViewCell.self, forCellReuseIdentifier: FriendsListTableViewCell.reuseId)
        tableView.separatorStyle = .none
        
        interactor?.makeRequest(request: .getFriends)
        interactor?.makeRequest(request: .getUser)
        
        addItemToNavBar()
    }
    
    func displayData(viewModel: FriendsList.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayFriends(let usersViewModel):
            self.friendsViewModel.cells = usersViewModel.cells.sorted { $0.lastName < $1.lastName}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .displayUser(let userViewModel):
            self.userViewModel = userViewModel
        }
    }
    
    func addItemToNavBar() {
        let filter = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(filterArray))
        let info = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(infoButton))
        self.navigationItem.rightBarButtonItem = filter
        self.navigationItem.leftBarButtonItem = info
        self.navigationController?.navigationBar.topItem?.title = "Список друзей"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - OBJC Methods + support method

extension FriendsListViewController {
    @objc func infoButton() {
        
        let alert = UIAlertController(title: "Информация о странице", message: "", preferredStyle: .alert)
        let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 380)
        alert.view.addConstraint(height)
        let cancel = UIAlertAction(title: "Выйти", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        present(alert, animated: true) {[weak self] in
            let photoSize = CGSize(width: 200, height: 200)
            let photoPoint = CGPoint(x: alert.view.frame.width / 2 - photoSize.width / 2, y: 50)
            let photoImage = WebImageView(frame: CGRect(origin: photoPoint, size: photoSize))
            photoImage.set(imageURL: self?.userViewModel.photo200)
            
            let xPoint = CGFloat(alert.view.frame.width / 2 - photoSize.width / 2)
            let nameStr = (self?.userViewModel.firstName)! + " " + (self?.userViewModel.lastName)!
            let friendsStr = "Колличество друзей: \(self?.userViewModel.friendsCount ?? 0)"
            
            let nameLabel = self?.setLabelInAlert(widht: 200, height: 40, pointX: xPoint, pointY: 260, text: nameStr, font: .systemFont(ofSize: 25, weight: .medium), colorText: .label, alignmentText: .center)
            let friendsCounterLabel = self?.setLabelInAlert(widht: 200, height: 40, pointX: xPoint, pointY: 295, text: friendsStr, font: .systemFont(ofSize: 17, weight: .light), colorText: .label, alignmentText: .center)
            
            alert.view.addSubview(photoImage)
            alert.view.addSubview(nameLabel!)
            alert.view.addSubview(friendsCounterLabel!)
            
            photoImage.layer.cornerRadius = photoImage.frame.height / 2
            photoImage.layer.masksToBounds = true
            photoImage.layer.borderWidth = 4
            photoImage.layer.borderColor = #colorLiteral(red: 0.2745098039, green: 0.5019607843, blue: 0.7607843137, alpha: 1)
        }
    }
    
    // Support method
    func setLabelInAlert(widht: Int, height: Int, pointX x: CGFloat, pointY y: CGFloat, text: String, font: UIFont, colorText: UIColor, alignmentText: NSTextAlignment ) -> UILabel{
        let labelSize = CGSize(width: widht, height: height)
        let labelPoint = CGPoint(x: x, y: y)
        let label = UILabel(frame: CGRect(origin: labelPoint, size: labelSize))
        label.text = text
        label.font = font
        label.textColor = colorText
        label.textAlignment = alignmentText
        return label
    }
    
    @objc func filterArray() {
        let alert = UIAlertController(title: "Отфильтровать?", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        let nameAToB = UIAlertAction(title: "По имени от А до Я", style: .default) {[weak self] action in
            self?.friendsViewModel.cells = (self?.friendsViewModel.cells.sorted { $0.firstName < $1.firstName})!
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        let nameBToA = UIAlertAction(title: "По имени от Я до А", style: .default) {[weak self] action in
            self?.friendsViewModel.cells = (self?.friendsViewModel.cells.sorted { $0.firstName > $1.firstName})!
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        let lastNameAToB = UIAlertAction(title: "По фамилии от А до Я", style: .default) {[weak self] action in
            self?.friendsViewModel.cells = (self?.friendsViewModel.cells.sorted { $0.lastName < $1.lastName})!
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        let lastNameAToBBToA = UIAlertAction(title: "По фамилии от Я до А", style: .default) {[weak self] action in
            self?.friendsViewModel.cells = (self?.friendsViewModel.cells.sorted { $0.lastName > $1.lastName})!
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(nameAToB)
        alert.addAction(nameBToA)
        alert.addAction(lastNameAToB)
        alert.addAction(lastNameAToBBToA)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension FriendsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsListTableViewCell.reuseId, for: indexPath) as! FriendsListTableViewCell
        let cellViewModel = friendsViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate
extension FriendsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = friendsViewModel.cells[indexPath.row].id
        interactor?.makeRequest(request: .openURL(id: id))
    }
}

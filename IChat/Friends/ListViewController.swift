//
//  ListViewController.swift
//  IChat
//
//  Created by Алексей Пархоменко on 25.12.2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit
import Firebase

protocol ListDisplayLogic: class {
    func displayData(viewModel: List.Model.ViewModel.ViewModelData)
}

class ListViewController: UIViewController, ListDisplayLogic {
    
    var interactor: ListBusinessLogic?
    var router: (NSObjectProtocol & ListRoutingLogic)?
    private var users: [UserProfile] = [] {
        didSet {
            table.reloadData()
        }
    }
    
    @IBOutlet weak var table: UITableView!
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = ListInteractor()
        let presenter             = ListPresenter()
        let router                = ListRouter()
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
        setup()
        setupTableView()
        view.backgroundColor = .brown
        getList()
    }
    
    func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    func getUserInfo() {
        guard let userProfile = UserService.shared.userProfile else { return }
        print("userProfile.firstname: \(userProfile.firstname)")
        print("userProfile.lastname: \(userProfile.lastname)")
        print("userProfile.sex: \(userProfile.sex)")
        print("userProfile.avatarURL: \(userProfile.avatarURL)")
        print("userProfile.uid: \(userProfile.uid)")
    }
    
    func getList() {
        guard let user = Auth.auth().currentUser else { return }
        print("4343434")
        UserService.shared.loadingUsers { (result) in
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func displayData(viewModel: List.Model.ViewModel.ViewModelData) {
        
    }
    
    @IBAction func getUserInfo(_ sender: Any) {
        getUserInfo()
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        try! Auth.auth().signOut()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = "\(user.firstname)"
        return cell
    }
    
    
}

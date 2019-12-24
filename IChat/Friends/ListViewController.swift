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
  }
    
    func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
  
  func displayData(viewModel: List.Model.ViewModel.ViewModelData) {

  }
    
    @IBAction func logOutTapped(_ sender: Any) {
        try! Auth.auth().signOut()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    
}

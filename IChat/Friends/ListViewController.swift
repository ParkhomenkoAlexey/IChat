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
    view.backgroundColor = .brown
  }
  
  func displayData(viewModel: List.Model.ViewModel.ViewModelData) {

  }
    
    @IBAction func logOutTapped(_ sender: Any) {
        try! Auth.auth().signOut()
    }
    
  
}

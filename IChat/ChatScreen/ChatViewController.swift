//
//  ChatViewController.swift
//  IChat
//
//  Created by Алексей Пархоменко on 13.12.2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol ChatDisplayLogic: class {
  func displayData(viewModel: Chat.Model.ViewModel.ViewModelData)
}

class ChatViewController: UIViewController, ChatDisplayLogic {

  var interactor: ChatBusinessLogic?
  var router: (NSObjectProtocol & ChatRoutingLogic)?
    
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = ChatInteractor()
    let presenter             = ChatPresenter()
    let router                = ChatRouter()
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
    view.backgroundColor = .red
  }
  
  func displayData(viewModel: Chat.Model.ViewModel.ViewModelData) {

  }
  
}

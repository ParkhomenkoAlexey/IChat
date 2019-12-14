//
//  ChatViewController.swift
//  IChat
//
//  Created by Алексей Пархоменко on 13.12.2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit
import SwiftUI

protocol ChatDisplayLogic: class {
    func displayData(viewModel: Chat.Model.ViewModel.ViewModelData)
}

class ChatViewController: UIViewController, ChatDisplayLogic {
    
    var messages: [ChatMessage] = []
    var interactor: ChatBusinessLogic?
    var router: (NSObjectProtocol & ChatRoutingLogic)?
    @IBOutlet weak var table: UITableView!
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
        setupTable()
        interactor?.makeRequest(request: .getMessages)
    }
    
    func setupTable() {
        table.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.reuseId)
        table.separatorStyle = .none
    }
    
    func displayData(viewModel: Chat.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayMessages(let messages):
            print("displayMessages")
            self.messages = messages
            self.table.reloadData()
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageCell.reuseId, for: indexPath) as! ChatMessageCell
        
        let message = messages[indexPath.row]
//        cell.messageLabel.text = message
        cell.set(message: message)
        return cell
    }
}

struct ChatProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let chatVC: ChatViewController = ChatViewController.loadFromStoryboard()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ChatProvider.ContainterView>) -> ChatViewController {
            return chatVC
        }
        
        func updateUIViewController(_ uiViewController: ChatProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ChatProvider.ContainterView>) {
            
        }
    }
}

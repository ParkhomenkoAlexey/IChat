//
//  ChatViewController.swift
//  IChat
//
//  Created by Алексей Пархоменко on 13.12.2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit
import SwiftUI
import FirebaseFirestore

protocol ChatDisplayLogic: class {
    func displayData(viewModel: Chat.Model.ViewModel.ViewModelData)
}

class ChatViewController: UIViewController, ChatDisplayLogic {
    
    var asiaMessages: [ChatMessage] = []
    var interactor: ChatBusinessLogic?
    
    var user: UserProfile?
    var channel: Channel?
    private var messages: [Message] = []
    private var messageListener: ListenerRegistration?
        
    
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
//        interactor?.makeRequest(request: .getMessages)
        print("user: \(user?.displayName) channel: \(channel?.name)")
    }
    
    // MARK: - Helpers
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      
      let testMessage = Message(user: user!, content: "I love pizza, what is your favorite kind?")
      insertNewMessage(testMessage)
    }
    
    private func insertNewMessage(_ message: Message) {
      guard !messages.contains(message) else {
        return
      }
      messages.append(message)
      messages.sort()
      table.reloadData()
    }
    
    func setupTable() {
        table.register(MessageCell.self, forCellReuseIdentifier: MessageCell.reuseId)
        table.separatorStyle = .none
    }
    
    // MARK: - first
    
   
    
    // 2
    func numberOfMessages(in messagesCollectionView: ChatViewController) -> Int {
      return messages.count
    }
    
    // 3
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: ChatViewController) -> MessageType {
      return messages[indexPath.section]
    }
    
    // 4
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
      let name = message.sender.displayName
      return NSAttributedString(string: name,
                                attributes: [
                                  .font: UIFont.preferredFont(forTextStyle: .caption1),
                                  .foregroundColor: UIColor(white: 0.3, alpha: 1)
      ])
    }
    
    // MARK: - displayData func
    
    func displayData(viewModel: Chat.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayMessages(let messages):
            print("displayMessages")
            self.asiaMessages = messages
            //self.table.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.reuseId, for: indexPath) as! MessageCell
        
//        let message = asiaMessages[indexPath.row]
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

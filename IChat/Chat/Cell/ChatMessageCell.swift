//
//  ChatMessageCell.swift
//  IChat
//
//  Created by Алексей Пархоменко on 14.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class ChatMessageCell: UITableViewCell {
    
    static let reuseId = "MessageCell"
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "We want to provide a longer string that is actually going to wrap onto the next line and maybe even a third line."
        label.numberOfLines = 0
        
        return label
    }()
    let bubbleBackgroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor(white: 0.85, alpha: 1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupConstraints()
        
    }
    
    func set(message: ChatMessage) {
        messageLabel.text = message.text
        
        if message.isIncoming {
            bubbleBackgroundView.backgroundColor = UIColor(white: 0.85, alpha: 1)
            messageLabel.textColor = .black
        } else {
            bubbleBackgroundView.backgroundColor = .black
            messageLabel.textColor = .white
        }
    }
    
    func setupConstraints() {
        
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)

        messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
//        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true

        bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16).isActive = true
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16).isActive = true
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16).isActive = true
        bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct MyProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let chatVC: ChatViewController = ChatViewController.loadFromStoryboard()
        func makeUIViewController(context: UIViewControllerRepresentableContext<MyProvider.ContainterView>) -> ChatViewController {
            return chatVC
        }
        
        func updateUIViewController(_ uiViewController: MyProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<MyProvider.ContainterView>) {
            
        }
    }
}

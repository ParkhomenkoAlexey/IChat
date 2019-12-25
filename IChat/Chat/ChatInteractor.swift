//
//  ChatInteractor.swift
//  IChat
//
//  Created by Алексей Пархоменко on 13.12.2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol ChatBusinessLogic {
    func makeRequest(request: Chat.Model.Request.RequestType)
}

class ChatInteractor: ChatBusinessLogic {
    
    var presenter: ChatPresentationLogic?
    var service: ChatWorker?
    
    func makeRequest(request: Chat.Model.Request.RequestType) {
        if service == nil {
            service = ChatWorker()
        }
        
        switch request {
        case .getMessages:
            print("getMessages")
            let chatMessages = [
                ChatMessage(text: "Here's my very first message", isIncoming: true),
                ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true),
                ChatMessage(text: "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false),
                ChatMessage(text: "Yo, dawg, Whaddup!", isIncoming: false),
                ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true),
            ]
            presenter?.presentData(response: .presentMessages(messages: chatMessages))
        }
    }
    
}

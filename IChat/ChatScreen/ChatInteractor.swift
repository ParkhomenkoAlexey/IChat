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
  var service: ChatService?
  
  func makeRequest(request: Chat.Model.Request.RequestType) {
    if service == nil {
      service = ChatService()
    }
  }
  
}

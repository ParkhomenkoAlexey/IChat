//
//  ChatPresenter.swift
//  IChat
//
//  Created by Алексей Пархоменко on 13.12.2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol ChatPresentationLogic {
  func presentData(response: Chat.Model.Response.ResponseType)
}

class ChatPresenter: ChatPresentationLogic {
  weak var viewController: ChatDisplayLogic?
  
  func presentData(response: Chat.Model.Response.ResponseType) {
  
  }
  
}

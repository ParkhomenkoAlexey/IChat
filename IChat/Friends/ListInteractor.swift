//
//  ListInteractor.swift
//  IChat
//
//  Created by Алексей Пархоменко on 25.12.2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol ListBusinessLogic {
  func makeRequest(request: List.Model.Request.RequestType)
}

class ListInteractor: ListBusinessLogic {

  var presenter: ListPresentationLogic?
  var service: ListService?
  
  func makeRequest(request: List.Model.Request.RequestType) {
    if service == nil {
      service = ListService()
    }
  }
  
}

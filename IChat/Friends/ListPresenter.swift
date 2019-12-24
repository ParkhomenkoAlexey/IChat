//
//  ListPresenter.swift
//  IChat
//
//  Created by Алексей Пархоменко on 25.12.2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol ListPresentationLogic {
  func presentData(response: List.Model.Response.ResponseType)
}

class ListPresenter: ListPresentationLogic {
  weak var viewController: ListDisplayLogic?
  
  func presentData(response: List.Model.Response.ResponseType) {
  
  }
  
}

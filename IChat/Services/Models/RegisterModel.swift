//
//  RegisterModel.swift
//  IChat
//
//  Created by Алексей Пархоменко on 20.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation
import UIKit

class RegisterModel {
    var firstname: String?
    var lastname: String?
    var photo: UIImage?
    var email: String?
    var password: String?
    var sex: Sex = .male
    
    //var userId: String
    
    var isFilled: Bool {
        guard !(firstname ?? "").isEmpty, !(lastname ?? "").isEmpty, !(email ?? "").isEmpty, !(password ?? "").isEmpty else {
            return false
        }
        return true
    }
    
    var dict: [String: Any] {
        return [
            "firstname": firstname ?? "",
            "lastname": lastname ?? "",
            "email": email ?? "",
            "password": password ?? "",
            "sex": sex.rawValue
        ]
    }
    
//    init() {
//        self.userId = UUID.init().uuidString
//    }
}

enum Sex: String {
    case male
    case female
}

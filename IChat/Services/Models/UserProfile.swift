//
//  UserModel.swift
//  IChat
//
//  Created by Алексей Пархоменко on 25.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation

class UserProfile {
    var uid: String
    var firstname: String
    var lastname: String
    var avatarURL: URL
    var sex: String
    
    var displayName: String {
        return "\(firstname) \(lastname)"
    }
    
    init(uid: String, firstname: String, lastname: String, avatarURL: URL, sex: String) {
        self.uid = uid
        self.firstname = firstname
        self.lastname = lastname
        self.avatarURL = avatarURL
        self.sex = sex
    }
}

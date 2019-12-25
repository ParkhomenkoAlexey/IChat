//
//  Message.swift
//  IChat
//
//  Created by Алексей Пархоменко on 25.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation

class Message: Codable {
    var id: String
    var sender: String?
    var text: String?
    var time: TimeInterval?
    
    init(id: String) {
        self.id = id
    }
}

//
//  ChatService.swift
//  IChat
//
//  Created by Алексей Пархоменко on 25.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation

class ChatService: FirebaseService {
    
    static let shared = ChatService()
    
    func send(message: Message) {
        guard let dict = message.dictionary else { return }
        chatsRef.child(message.id).setValue(dict)
    }
    
}

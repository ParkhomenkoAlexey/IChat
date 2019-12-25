//
//  FirebaseService.swift
//  IChat
//
//  Created by Алексей Пархоменко on 25.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation

import Foundation
import FirebaseDatabase

class FirebaseService {
    var sourceRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var usersRef: DatabaseReference {
        return sourceRef.child("users")
    }
    
    var chatsRef: DatabaseReference {
        return sourceRef.child("chats")
    }
}

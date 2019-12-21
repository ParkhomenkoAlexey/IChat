//
//  AuthService.swift
//  IChat
//
//  Created by Алексей Пархоменко on 20.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Firebase

class AuthService {
    static let shared = AuthService()
    private init() { }

    private let auth = Auth.auth()
    private let ref = Database.database().reference()
    
    private var usersRef: DatabaseReference {
        ref.child("users")
    }
    
    func register(with model: RegisterModel, completion: () -> Void) {
        guard let email = model.email, let password = model.password else { return }
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("\(error?.localizedDescription)")
            } else {
                let userID = result!.user.uid
                var dict = model.dict
                dict["id"] = userID
                self.usersRef.child(userID).setValue(dict)
            }
        }
    }
}

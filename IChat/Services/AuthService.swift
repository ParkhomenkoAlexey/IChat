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

class AuthService: FirebaseService {
    static let shared = AuthService()
    private override init() { }
    
    private let auth = Auth.auth()
    
    
    
    func login(email: String, password: String, completion: @escaping VoidResultHandler) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success)
            
        }
    }
    
    func register(with model: RegisterModel, completion: @escaping (Result<Void>) -> Void) {
        
        guard model.isFilled else {
            completion(.failure(AuthError.unknownError))
            return
        }
        
        guard let email = model.email, let password = model.password else {
            completion(.failure(AuthError.unknownError))
            return
        }
        
        guard Validators.isSimpleEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        
        guard let photo = model.photo else {
            completion(.failure(AuthError.photoNotExist))
            return
        }
        
        auth.createUser(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            let userID = result.user.uid
            let currentUserRef = self.usersRef.child(userID)
            var dict = model.dict
            dict["uid"] = userID
            StorageService.shared.upload(photo: photo) { (result) in
                switch result {
                case .success(let avatarURL):
                    dict["avatarURL"] = avatarURL.absoluteString // проверить + "jpg"
                    currentUserRef.setValue(dict) { (error, ref) in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(()))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } // createUser
    } // register
}


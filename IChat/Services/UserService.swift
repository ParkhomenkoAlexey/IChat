//
//  UserService.swift
//  IChat
//
//  Created by Алексей Пархоменко on 25.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation
import Firebase

class UserService: FirebaseService {
    static let shared = UserService()
    private override init() { }
    var userProfile: UserProfile?
    
    func observeUserProfile(uid: String, completion: @escaping ResultHandler<UserProfile>) {
        let userRef = usersRef.child(uid)
        userRef.observe(.value) { (snapshot) in
            
            var userProfile: UserProfile?
            
            if let dict = snapshot.value as? [String: Any],
                let firstname = dict["firstname"] as? String,
                let lastname = dict["lastname"] as? String,
                let avatarURL = dict["avatarURL"] as? String,
                let sex = dict["sex"] as? String,
                let url = URL(string: avatarURL) {
                
                userProfile = UserProfile(uid: snapshot.key,
                                          firstname: firstname,
                                          lastname: lastname,
                                          avatarURL: url,
                                          sex: sex)
                if let userProfile = userProfile {
                    completion(.success(userProfile))
                } else {
                    completion(.failure(UserError.userProfileUnwrapError))
                }
            } else {
                completion(.failure(UserError.dictInitialisationError))
            }
        }
    }
    
    func loadingUsers(completion: @escaping ResultHandler<[UserProfile]>) {
        
        usersRef.observe(.value) { (snapshot) in
            if let dict = snapshot.value as? [String: [String: Any]] {
                let users = dict.map { (userDict) -> UserProfile in
                    return UserProfile(uid: userDict.key,
                                       firstname: userDict.value["firstname"] as! String,
                                       lastname: userDict.value["lastname"] as! String,
                                       avatarURL: URL(string: userDict.value["avatarURL"] as! String) ?? URL(string: "")!,
                                       sex: userDict.value["sex"] as! String)
                }
                completion(.success(users))
            } else {
                completion(.failure(UserError.dictInitialisationError))
            }
        }
    }
}

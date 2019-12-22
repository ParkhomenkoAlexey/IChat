//
//  StorageManager.swift
//  IChat
//
//  Created by Алексей Пархоменко on 22.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//


import UIKit
import FirebaseStorage
import Firebase

class StorageService {
    static let shared = StorageService()
    private init() { }
    
    let storageRef = Storage.storage().reference()
    private var avatarsRef: StorageReference {
//        storageRef.child(Keys.avatars.rawValue) // не вижу смысла
        storageRef.child("avatars")
    }
    
    func upload(photo: UIImage, closure: @escaping ResultHandler<URL>) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let imageData = photo.jpegData(compressionQuality: 0.5) else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        avatarsRef.child(uid).putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                closure(.failure(error!))
                return
            }
            self.avatarsRef.child(uid).downloadURL { (url, error) in
                guard let downloadURL = url else {
                    closure(.failure(error!))
                    return
                }
                closure(.success(downloadURL))
            }
        }
    }
}

extension StorageService {
    private enum Keys: String {
        case avatars
    }
}

//
//  Message.swift
//  IChat
//
//  Created by Алексей Пархоменко on 25.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol MessageType {
    var sender: Sender { get }
    var messageId: String { get }
    var sentDate: Date { get }
    var data: MessageData { get }
}

class Message: MessageType {
    var id: String?
    var sender: Sender
    let content: String
    let sentDate: Date
    
    var data: MessageData {
      if let image = image {
        return .photo(image)
      } else {
        return .text(content)
      }
    }

    var messageId: String {
      return id ?? UUID().uuidString
    }

    var image: UIImage? = nil
    var downloadURL: URL? = nil

    init(user: UserProfile, content: String) {
        sender = Sender(id: user.uid, displayName: "\(user.firstname) \(user.lastname)")
      self.content = content
      sentDate = Date()
      id = nil
    }

    init(user: UserProfile, image: UIImage) {
      sender = Sender(id: user.uid, displayName: "\(user.firstname) \(user.lastname)")
      self.image = image
      content = ""
      sentDate = Date()
      id = nil
    }

    init?(document: QueryDocumentSnapshot) {
      let data = document.data()

      guard let sentDate = data["created"] as? Date else {
        return nil
      }
      guard let senderID = data["senderID"] as? String else {
        return nil
      }
      guard let senderName = data["senderName"] as? String else {
        return nil
      }

      id = document.documentID

      self.sentDate = sentDate
      sender = Sender(id: senderID, displayName: senderName)

      if let content = data["content"] as? String {
        self.content = content
        downloadURL = nil
      } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
        downloadURL = url
        content = ""
      } else {
        return nil
      }
    }
}

extension Message {
  
  var representation: [String : Any] {
    var rep: [String : Any] = [
      "created": sentDate,
      "senderID": sender.id,
      "senderName": sender.displayName
    ]
    
    if let url = downloadURL {
      rep["url"] = url.absoluteString
    } else {
      rep["content"] = content
    }
    
    return rep
  }
  
}

enum MessageData {
    case text(String)
    case attributedText(NSAttributedString)
    case photo(UIImage)
    case video(file: URL, thumbnail: UIImage)
    case emoji(String)
}

extension Message: Comparable {
  
  static func == (lhs: Message, rhs: Message) -> Bool {
    return lhs.id == rhs.id
  }
  
  static func < (lhs: Message, rhs: Message) -> Bool {
    return lhs.sentDate < rhs.sentDate
  }
  
}

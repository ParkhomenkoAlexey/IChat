//
//  Sender.swift
//  IChat
//
//  Created by Алексей Пархоменко on 26.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation


class Sender {
    let id: String
    let displayName: String
    
    init(id: String, displayName: String) {
        self.id = id
        self.displayName = displayName
    }
}

extension Sender: Equatable {

    /// Two senders are considered equal if they have the same id.
    public static func == (left: Sender, right: Sender) -> Bool {
        return left.id == right.id
    }

}

//
//  ChatModels.swift
//  IChat
//
//  Created by Алексей Пархоменко on 13.12.2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

enum Chat {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getMessages
            }
        }
        struct Response {
            enum ResponseType {
                case presentMessages(messages: [ChatMessage])
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayMessages(messages: [ChatMessage])
            }
        }
    }
}

struct ChatMessage {
    let text: String
    let isIncoming: Bool
}

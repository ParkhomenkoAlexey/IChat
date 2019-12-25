//
//  AuthErrors.swift
//  IChat
//
//  Created by Алексей Пархоменко on 22.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case unknownError
    case serverError
    case photoNotExist
}

enum UserError {
    case dictInitialisationError
    case userProfileUnwrapError
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dictInitialisationError:
            return NSLocalizedString("Can't convert snapshot.value in dict", comment: "")
        case .userProfileUnwrapError:
            return NSLocalizedString("Can't unwrap userProfile", comment: "")
        }
    }
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .invalidEmail:
            return NSLocalizedString("email_is_not_valid", comment: "")
        case .unknownError:
            /// we will use server_error key to display user internal error
            return NSLocalizedString("server_error", comment: "")
        case .serverError:
            return NSLocalizedString("server_error", comment: "")
            case .photoNotExist:
            return NSLocalizedString("Пользователь не выбрал фотографию", comment: "")
        }
    }
}

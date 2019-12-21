//
//  UIAlertController + Entension.swift
//  IChat
//
//  Created by Алексей Пархоменко on 21.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

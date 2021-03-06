//
//  LoginViewController.swift
//  FirebaseWebinar
//
//  Created by Алексей Пархоменко on 15.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        AuthService.shared.login(email: emailTextField.text!, password: passwordTextField.text!) { (result) in
            switch result {
            case .success:
                self.showAlert(with: "Успешно", and: "Вы авторизированны")
            case .failure(let error):
                self.showAlert(with: "Ошибка", and: error.localizedDescription)
            }
        }
    }
    
}

//
//  SignInViewController.swift
//  FirebaseWebinar
//
//  Created by Алексей Пархоменко on 15.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var registerModel = RegisterModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signInPressed(_ sender: Any) {
        registerModel.password = passwordTextField.text
        registerModel.email = emailTextField.text
        AuthService.shared.register(with: registerModel) {
            self.showAlert(with: "Успешно", and: "Вы зарегистрированны!")
        }
    }
}

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
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    
    private var registerModel = RegisterModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Decorator.decorate(self)
    }
    
    private func photoViewClicked() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
// MARK: - @IBActions
    
    @IBAction func signInPressed(_ sender: Any) {
        registerModel.password = passwordTextField.text
        registerModel.email = emailTextField.text
        AuthService.shared.register(with: registerModel) {
            self.showAlert(with: "Успешно", and: "Вы зарегистрированны!")
        }
    }
    
    @IBAction func addPhotoTapped(_ sender: UIButton) {
        photoViewClicked()
    }
    
    @IBAction func chooseSexTapped(_ sender: UISegmentedControl) {
        let index = sexSegmentedControl.selectedSegmentIndex
        let sex: Sex = index == 0 ? .male : .female
        registerModel.sex = sex
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SignInViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        registerModel.photo = image
        profileImage.image = image
    }
}

// MARK: - Decorator
extension SignInViewController {
  fileprivate class Decorator {
    private init() {}
    
    static func decorate(_ vc: SignInViewController) {
        vc.profileImage.layer.borderColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
        vc.profileImage.layer.borderWidth = 1
        vc.profileImage.contentMode = .scaleAspectFill
        
        // layoutSubviews
        vc.profileImage.layer.cornerRadius = vc.profileImage.frame.height / 2
    }
  }
}

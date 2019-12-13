//
//  UserCriationController.swift
//  Trythis
//
//  Created by user136320 on 12/9/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import UIKit

class UserCriationController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var email               : UITextField!
    @IBOutlet weak var password            : UITextField!
    @IBOutlet weak var passwordConfirmation: UITextField!
    @IBOutlet weak var register: UIButton!
    
    override func viewDidLoad() {
        email.delegate = self
        password.delegate = self
        passwordConfirmation.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            password.becomeFirstResponder()
            return true
        }
        if textField == password {
            passwordConfirmation.becomeFirstResponder()
            return true
        }
        if textField == passwordConfirmation {
            onClickCreate(register)
        }
        return true
    }
    
    @IBAction func onClickCreate(_ sender: UIButton) {
        email.resignFirstResponder()
        password.resignFirstResponder()
        passwordConfirmation.resignFirstResponder()
        let isValidEmail = AuthenticationPresenter.isValid(email: email.text!)
        if isValidEmail {
            let isValidPassword = AuthenticationPresenter.isValid(password: password.text!)
            if isValidPassword && password.text! == passwordConfirmation.text! {
                let callback = {(_ success: Bool) -> Void in
                    if success {
                        self.alert("Usuário criado com sucesso")
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.showError("Não foi possível criar o usuário")
                    }
                }
                AuthenticationServices.createUser(email: email.text!, password: password.text!, callback: callback)
            } else {
                self.showError("A senha deve ter pelo menos 6 caracteres!")
            }
        } else {
            self.showError("Email inválido!")
        }
    }
}

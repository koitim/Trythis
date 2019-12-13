//
//  LoginController.swift
//  Trythis
//
//  Created by user136320 on 12/9/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var email   : UITextField!
    @IBOutlet weak var password: UITextField!    
    
    @IBAction func onClickLogin(_ sender: UIButton) {
        email.resignFirstResponder()
        password.resignFirstResponder()
        let isValidEmail = AuthenticationPresenter.isValid(email: email.text!)
        if isValidEmail {
            let isValidPassword = AuthenticationPresenter.isValid(password: password.text!)
            if isValidPassword {
                
                let callback = {(_ success: Bool/*, _ error: Error?*/) -> Void in
                    if success {
                        if let initialVC = UIStoryboard(name: "Trythis", bundle: nil).instantiateInitialViewController() {
                            self.present(initialVC, animated: true, completion: nil)
                        }
                    } else {
                        self.alert("Ocorreu algum erro")
                    }
                }
                AuthenticationServices.signIn(email: email.text!, pass: password.text!, callback: callback)
            } else {
                self.showError("A senha deve ter pelo menos 6 caracteres!")
            }
        } else {
            self.showError("Email inválido!")
        }
    }
    
}

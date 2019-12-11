//
//  AuthenticationServices.swift
//  Trythis
//
//  Created by user136320 on 12/9/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthenticationServices {
    
    class func signIn(email: String, pass: String, callback: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error {
                let aec = AuthErrorCode(rawValue: error._code)
                let tx2 = aec.debugDescription
                
                callback(false)
            } else {
                callback(true)
            }
        }
    }
  
    
    class func createUser(email: String, password: String, callback: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let error = error {
                callback(false)
            } else {
                callback(true)
            }
        }
    }
}

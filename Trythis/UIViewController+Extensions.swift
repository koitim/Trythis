//
//  UIViewController+Extensions.swift
//  Trythis
//
//  Created by user136320 on 12/9/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(_ msg: String) {
        let alertController = UIAlertController(title: "Alerta", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showError(_ msg: String) {
        let error = UIAlertController(title: "Erro", message: msg, preferredStyle: UIAlertControllerStyle.actionSheet)
        error.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
        self.present(error, animated: true, completion: nil)
    }
}

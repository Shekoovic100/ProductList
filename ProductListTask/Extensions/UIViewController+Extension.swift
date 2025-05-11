//
//  UIViewController+Extension.swift
//  ProductListTask
//
//  Created by sherif on 11/05/2025.
//

import UIKit


extension UIViewController {
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK" , style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}

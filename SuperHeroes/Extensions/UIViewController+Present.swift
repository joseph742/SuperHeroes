//
//  UIViewController+Present.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
import UIKit


protocol ShowAlert {
  func showAlertView(with title: String, message: String, actions: [UIAlertAction]?)
}

/*
 Description: presents an UIAlertview with a title and message
 parameters1: title
 parameters2: messge
 parameters3: actions
 */

extension ShowAlert where Self: UIViewController {
  func showAlertView(with title: String, message: String, actions: [UIAlertAction]? = nil) {
    guard presentedViewController == nil else {
      return
    }
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    actions?.forEach { action in
      alertController.addAction(action)
    }
    present(alertController, animated: true)
  }
}

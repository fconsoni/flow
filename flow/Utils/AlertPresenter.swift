//
//  AlertPresenter.swift
//  flow
//
//  Created by Usuario on 12/6/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit

class AlertPresenter {
  static func presentError(on vc: UIViewController, message: String? = "") {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nop))
    vc.present(alert, animated: true, completion: nil)
  }
  
  static func presentInfo(on vc: UIViewController, message: String? = "") {
    let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nop))
    vc.present(alert, animated: true, completion: nil)
  }
}

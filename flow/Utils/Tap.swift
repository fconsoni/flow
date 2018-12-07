//
//  Tap.swift
//  Example
//
//  Created by Franco Consoni on 08/11/2017.
//

import UIKit

class Tap {
  private static var instances: [Tap] = []
  
  private weak var view: UIView?
  private var action: () -> Void
  private(set) var tapGesture: UITapGestureRecognizer
  
  
  static func removeTap(on view: UIView) {
    if let tap = instances.filter({ $0.view == view }).first {
      tap.view?.removeGestureRecognizer(tap.tapGesture)
    }
    instances = instances.filter { $0.view != view }
  }
  
  func changeAction(_ callback: @escaping () -> Void) {
    action = callback
  }
  
  @discardableResult static func on(_ view: UIView, fires action: @escaping ()->()) -> Tap {
    let tap = Tap(view: view, action: action)
    instances.append(tap)
    instances = instances.filter { $0.view != nil }
    return tap
  }
  
  var isEnabled: Bool = true
  
  private init(view: UIView, action: @escaping () -> Void) {
    self.view = view
    self.action = action
    self.tapGesture = UITapGestureRecognizer()
    tapGesture.addTarget(self, action: #selector(Tap.onTap(_:)))
    view.addGestureRecognizer(tapGesture)
    
    view.isUserInteractionEnabled = true
  }
  
  @objc private func onTap(_ gesture: UIGestureRecognizer) {
    if (gesture.state == .ended) {
      fireAction()
    }
  }
  
  func fireAction() {
    guard isEnabled else { return }
    action()
  }
  
}

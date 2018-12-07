//
//  XibView.swift
//
//  Created by Usuario
//

import UIKit

class XibControl: UIControl {
  var xibName: String?
  
  required override init(frame: CGRect = CGRect.zero) {
    super.init(frame: frame); commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder); commonInit()
  }
  
  internal func commonInit() {
    setupFromXib()
  }
  
  private func setupFromXib() {
    let xibName = self.xibName ?? String(describing: type(of: self))
    
    let viewsInXib = Bundle(for: type(of: self)).loadNibNamed(xibName, owner: self, options: nil)
    guard let view = viewsInXib?.first as? UIView else {
      return
    }
    
    self.addSubview(view)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: self.topAnchor),
      view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      view.rightAnchor.constraint(equalTo: self.rightAnchor),
      view.leftAnchor.constraint(equalTo: self.leftAnchor),
      ])
    
    self.backgroundColor = UIColor.clear
  }
  
}

class XibView: UIView {
  var xibName: String?
  
  required override init(frame: CGRect = CGRect.zero) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  internal func commonInit() {
    setupFromXib()
  }
  
  private func setupFromXib() {
    let xibName = self.xibName ?? String(describing: type(of: self))
    
    let viewsInXib = Bundle(for: type(of: self)).loadNibNamed(xibName, owner: self, options: nil)
    guard let view = viewsInXib?.first as? UIView else {
      return
    }
    
    self.addSubview(view)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: self.topAnchor),
      view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      view.rightAnchor.constraint(equalTo: self.rightAnchor),
      view.leftAnchor.constraint(equalTo: self.leftAnchor),
      ])
    
    self.backgroundColor = UIColor.clear
  }
}

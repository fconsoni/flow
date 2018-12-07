//  
//  CityCellUiView.swift
//  flow
//
//  Created by Usuario on 12/7/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit

class CityCellUiView : XibView {
  @IBOutlet private weak var cityNameLabel: UILabel!
  
  override func commonInit() {
    super.commonInit()
    self.backgroundColor = .clear
    self.setName("hola")
  }
  
  func setName(_ name: String) {
    self.cityNameLabel.text = name
  }
}

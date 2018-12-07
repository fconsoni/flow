//  
//  StartView2.swift
//  flow
//
//  Created by Usuario on 12/5/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit

class StartView : XibView {
  @IBOutlet private weak var cityNameLabel: UILabel!
  
  override func commonInit() {
    super.commonInit()
  }
  
  func setWith(_ weather: Weather) {
    self.cityNameLabel.text = weather.city.name
  }
}

//  
//  StatusUiView.swift
//  flow
//
//  Created by Usuario on 12/7/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit

class StatusUiView : XibView {
  @IBOutlet private weak var tempLabel: UILabel!
  @IBOutlet private weak var cloudsPercentile: UILabel!
  @IBOutlet private weak var iconImage: UIImageView!
  
  override func commonInit() {
    super.commonInit()
  }
  
  func setWeather(_ weather: Weather) {
    self.tempLabel.text = "\(weather.actual.temp) ºC"
    self.cloudsPercentile.text = "\(weather.actual.cloudPercent) %"
    self.iconImage.image = weather.getActualIcon()
  }
}

//  
//  ForecastUiView.swift
//  flow
//
//  Created by Usuario on 12/7/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit

class ForecastUiView : XibView {
  @IBOutlet private weak var hourLabel: UILabel!
  @IBOutlet private weak var tempLabel: UILabel!
  @IBOutlet private weak var cloudsPercent: UILabel!
  @IBOutlet private weak var statusIcon: UIImageView!
  
  override func commonInit() {
    super.commonInit()
    self.backgroundColor = .clear
  }
  
  func setWith(_ forecast: Weather.Forecast) {
    self.hourLabel.text = getDayHourFrom(forecast.date).description + " hs"
    self.tempLabel.text = "\(forecast.temp) ºC"
    self.cloudsPercent.text = "\(forecast.cloudPercent) %"
    self.statusIcon.image = forecast.getIcon()
  }
}

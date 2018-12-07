//
//  NextDayCell.swift
//  flow
//
//  Created by Usuario on 12/7/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
  @IBOutlet private weak var forecastView: ForecastUiView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func setWith(_ forecast: Weather.Forecast) {
    self.forecastView.setWith(forecast)
  }

}

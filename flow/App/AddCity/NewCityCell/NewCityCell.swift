//
//  NewCityCell.swift
//  flow
//
//  Created by Usuario on 12/7/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit

class NewCityCell: UITableViewCell {
  @IBOutlet private weak var countryLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setCountry(_ country: Country) {
    self.countryLabel.text = "\(country.capitalCity.name), \(country.name)"
  }

}

//
//  CityCell.swift
//  flow
//
//  Created by Usuario on 12/7/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
  @IBOutlet private weak var cityNameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func setName(_ name: String) {
    self.cityNameLabel.text = name
  }
}

//
//  DetailsVC.swift
//  flow
//
//  Created by Usuario on 12/7/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet private weak var cityLabel: UILabel!
  @IBOutlet private weak var countryLabel: UILabel!
  @IBOutlet private weak var statusView: StatusUiView!
  @IBOutlet private weak var tableView: UITableView!
  
  private var country: Country!

  override func viewDidLoad() {
    super.viewDidLoad()
    if self.view != nil {}
    
    self.setTitles()
    self.getForecast()
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func getForecast() {
    onMainDo(SVProgressHUD.show, onBackgroundDo: { () -> Void in
      WeatherService(onDataRecieved: self.keepResult).getForecastFor(self.country)
    }, thenOnMainDo: SVProgressHUD.dismiss)
  }
  
  private func keepResult(_ result: Result<Weather>) {
    guard let forecast = result.toOptional() else {
      AlertPresenter.presentError(on: self, message: "Cannot retrieve actual forecast for this city")
      return
    }
    
    self.country = self.country.copy(weather: forecast)
    self.statusView.setWeather(forecast)
    self.tableView.reloadData()
  }
  
  func showForecastOf(_ country: Country) {
    self.country = country
  }
  
  private func setTitles() {
    self.cityLabel.text = self.country.capitalCity.name
    self.countryLabel.text = self.country.name
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.country.weather.fold(0, { $0.nextDaysForecast.count })
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "forecast") as! ForecastCell
    
    return cell
  }
}

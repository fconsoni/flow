//
//  InicioVC.swift
//  flow
//
//  Created by Usuario on 12/5/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit
import SVProgressHUD

class StartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet private weak var tableView: UITableView!
  private var result: Result<Weather>!
  private var cities: [City] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    if self.view != nil {}
    
    tableView.delegate = self
    tableView.dataSource = self
    
    self.prepareData()
  }
  
  private func prepareData() {
    onMainDo(SVProgressHUD.show, onBackgroundDo: { () -> Void in
      WeatherService(onDataRecieved: self.keepResult).getForecastFor(cityName: "buenos+aires", countryCode: "ar")
    }, thenOnMainDo: {
      SVProgressHUD.dismiss()
    })
  }
  
  private func setDataInView() {
    if !self.result.isSuccess() {
      AlertPresenter.presentError(on: self, message: "Something went wrong when retriving weather")
    } else {
      let weather: Weather = try! self.result.get()
      self.cities.append(weather.city)
      
      self.tableView.reloadData()
    }
  }
  
  private func keepResult(_ result: Result<Weather>) {
    self.result = result
    self.setDataInView()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: CityCell = self.tableView.dequeueReusableCell(withIdentifier: "CityCell") as! CityCell
    
    let name = self.cities.map{ $0.name }[indexPath.row]
    cell.setName(name)
    
    return cell
  }

  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

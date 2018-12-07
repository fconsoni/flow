//
//  DetailsVC.swift
//  flow
//
//  Created by Usuario on 12/7/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  //  private func prepareData() {
  //    onMainDo(SVProgressHUD.show, onBackgroundDo: { () -> Void in
  //      WeatherService(onDataRecieved: self.keepResult).getForecastFor(cityName: "buenos+aires", countryCode: "ar")
  //    }, thenOnMainDo: {
  //      SVProgressHUD.dismiss()
  //      self.enableButton(true)
  //    })
  //  }
  //
  //  private func keepResult(_ result: Result<Weather>) {
  //    self.result = result
  //    self.setDataInView()
  //  }
  //
  //  private func setDataInView() {
  //    if !self.result.isSuccess() {
  //      AlertPresenter.presentError(on: self, message: "Something went wrong when retriving weather")
  //    } else {
  //      let weather: Weather = try! self.result.get()
  //      self.cities.append(weather.city)
  //
  //      self.tableView.reloadData()
  //    }
  //  }
  
  
  func showForecastOf(_ country: Country) {
    
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

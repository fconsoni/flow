//
//  InicioVC.swift
//  flow
//
//  Created by Usuario on 12/5/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit
import SVProgressHUD

class StartVC: UIViewController {
  @IBOutlet private weak var startView: StartView!
  
  private var result: Result<Weather>!

    override func viewDidLoad() {
        super.viewDidLoad()
      if self.view != nil {}
      
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
      self.startView.setWith(weather)
    }
  }
  
  private func keepResult(_ result: Result<Weather>) {
    self.result = result
    self.setDataInView()
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

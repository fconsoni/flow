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
  @IBOutlet private weak var addButton: UIButton!
  
  private var result: Result<Weather>!
  private var countries: [Country] = []
  private var selectedCountry: Country!

  override func viewDidLoad() {
    super.viewDidLoad()
    if self.view != nil {}
    
    self.setArgentina()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    self.addButton.setTitleColor(.gray, for: .disabled)
    
    self.navigationController?.setViewControllers([self], animated: true)
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.selectedCountry = self.countries[indexPath.row]
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: CityCell = self.tableView.dequeueReusableCell(withIdentifier: "CityCell") as! CityCell
    
    let name = self.countries.map{ $0.capitalCity.name }[indexPath.row]
    cell.setName(name)
    
    return cell
  }

  @IBAction func about(sender: AnyObject) {
    performSegue(withIdentifier: "AddCity", sender: sender)
  }
  
  private func setArgentina() {
    let arg = Country.init(name: "Argentina",
                           code: "AR",
                           capitalCity: City(name: "Buenos Aires"))
    self.countries.append(arg)
    self.selectedCountry = arg
  }
  
  func recieveNewCountry(_ country: Country) {
    self.countries.append(country)
    self.tableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.destination is DetailsVC {
      let dest = segue.destination as! DetailsVC
      dest.showForecastOf(self.selectedCountry)
    }
  }

}

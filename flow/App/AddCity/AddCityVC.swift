//
//  ViewController.swift
//  flow
//
//  Created by Usuario on 12/5/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddCityVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var searchTextField: UITextField!
  @IBOutlet private weak var okButton: UIButton!
  
  private var countries: [Country] = []
  private var selectedCountry: Country!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if self.view != nil {}
    
    tableView.delegate = self
    tableView.dataSource = self
    
    self.searchTextField.text = "argen"
    //self.enableButton(false)
  }
  
  
  
  private func getCountries() {
    onMainDo(SVProgressHUD.show, onBackgroundDo: {
      CountryService(onDataRecieved: self.keepResults).getCountryList(withName: self.searchTextField.text!)
    }, thenOnMainDo: SVProgressHUD.dismiss)
  }
  
  private func keepResults(_ results: Result<[Country]>) -> Void {
    if !results.isSuccess() {
      AlertPresenter.presentError(on: self, message: "Something went wrong when retriving countries")
    } else {
      self.countries = try! results.get()
      
      self.tableView.reloadData()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.selectedCountry = self.countries[indexPath.row]
    self.gotToStart()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NewCityCell") as! NewCityCell
    
    cell.setCountry(self.countries[indexPath.row])
    
    return cell
  }
  
  private func enableButton(_ val: Bool) {
    self.okButton.isEnabled = val
  }
  
  @IBAction func searchForCountries(sender: AnyObject) {
    self.getCountries()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let dest = segue.destination as! StartVC
    
    dest.recieveNewCountry(self.selectedCountry)
  }
  
  //Una manera manual de manejar el set as root (muy fea, pero valida)
  private func gotToStart() {
    let vcs = self.navigationController.fold([], { $0.viewControllers })
    (vcs.first! as! StartVC).recieveNewCountry(self.selectedCountry)
    self.navigationController?.setViewControllers(vcs.take(1), animated: true)
  }
}


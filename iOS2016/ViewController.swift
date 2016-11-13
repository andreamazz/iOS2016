//
//  ViewController.swift
//  iOS2016
//
//  Created by Andrea Mazzini on 13/11/2016.
//  Copyright © 2016 Andrea Mazzini. All rights reserved.
//

import UIKit
import Alamofire

let APPID = "8bf89043ed67d500bd2942c4f4084f45"

class ViewController: UIViewController {


  /// An array with the weather data
  var data: [Any] = []

  /// A dictionary with the city's info
  var city: [String: Any] = [:]

  @IBOutlet var searchTextField: UITextField?
  @IBOutlet var tableView: UITableView?

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Weather"
  }

  func searchCityBy(name: String?) {
    guard let name = name else { return }

    let parameters = ["appid": APPID, "q": name]

    Alamofire.request("http://api.openweathermap.org/data/2.5/forecast", parameters: parameters).responseJSON { response in
      guard let json = response.result.value as? [String: Any] else { return }

      if let city = json["city"] as? [String: Any] {
        self.city = city
      }

      if let list = json["list"] as? [Any] {
        self.data = list
      }

      self.updateUI()
    }
  }

  func updateUI() {
    if let name = city["name"] as? String {
      title = name
    } else {
      title = "No city found"
    }
  }

  @IBAction func searchAction(_ sender: Any) {
    searchCityBy(name: searchTextField?.text)
    searchTextField?.resignFirstResponder()
  }

}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    searchCityBy(name: searchTextField?.text)
    return true
  }
}

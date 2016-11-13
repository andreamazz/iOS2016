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

  @IBOutlet var searchTextField: UITextField?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func searchCityBy(name: String?) {
    guard let name = name else { return }

    let parameters = ["appid": APPID, "q": name]

    Alamofire.request("http://api.openweathermap.org/data/2.5/forecast", parameters: parameters).responseJSON { response in
      guard let json = response.result.value as? [String: Any] else { return }

      print(json)
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

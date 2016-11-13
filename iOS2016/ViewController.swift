//
//  ViewController.swift
//  iOS2016
//
//  Created by Andrea Mazzini on 13/11/2016.
//  Copyright © 2016 Andrea Mazzini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var searchTextField: UITextField?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func searchCityBy(name: String?) {
    guard let name = name else { return }
  }

  @IBAction func searchAction(_ sender: Any) {
    searchCityBy(name: searchTextField?.text)
  }

}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    searchCityBy(name: searchTextField?.text)
    return true
  }
}

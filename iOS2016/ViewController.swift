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

  let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "dd MMMM, HH:mm"
    return df
  }()

  @IBOutlet var searchTextField: UITextField?
  @IBOutlet var tableView: UITableView? {
    didSet {
      tableView?.tableFooterView = UIView()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Weather"
  }

  func searchCityBy(name: String?) {
    guard let name = name else { return }

    let parameters = ["appid": APPID, "q": name, "units": "metric"]

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
    tableView?.reloadData()
  }

  @IBAction func searchAction(_ sender: Any) {
    searchCityBy(name: searchTextField?.text)
    searchTextField?.resignFirstResponder()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let cell = sender as? UITableViewCell, let index = tableView?.indexPath(for: cell)?.row else { return }
    guard let item = data[index] as? [String: Any] else { return }
    guard let controller = segue.destination as? DetailViewController else { return }

    controller.data = item
  }

}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    searchCityBy(name: searchTextField?.text)
    return true
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let item = data[indexPath.row] as? [String: Any] else { return UITableViewCell() }

    let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)

    if let weather = item["weather"] as? [[String: Any]],
      let time = item["dt"] as? Double,
      let icon = weather.first?["icon"] as? String {

      let date = Date(timeIntervalSince1970: time)
      cell.textLabel?.text = dateFormatter.string(from: date)

      let index = icon.index(icon.startIndex, offsetBy: 2)
      let iconName = icon.substring(to: index)
      if let image = UIImage(named: iconName) {
        cell.imageView?.image = image
      }
      if iconName == "01" {
        UIView.animate(withDuration: 2, delay: 0, options: [.autoreverse, .repeat] , animations: {
          cell.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: nil)
      }
    }

    if let main = item["main"] as? [String: Any],
      let temp = main["temp"] as? Double {
      cell.detailTextLabel?.text = "\(temp)°"
    }

    return cell
  }
}

//
//  DetailViewController.swift
//  iOS2016
//
//  Created by Andrea Mazzini on 14/11/2016.
//  Copyright © 2016 Andrea Mazzini. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet var tableView: UITableView? {
    didSet {
      tableView?.tableFooterView = UIView()
    }
  }
  @IBOutlet var label: UILabel?
  @IBOutlet var imageView: UIImageView?

  static let storyboardIdentifier = "DetailViewController"

  var data: [String: Any] = [:]

  let temperatureKeys = ["temp", "temp_min", "temp_max", "pressure", "sea_level", "grnd_level", "humidity"]
  let windKeys = ["speed", "deg"]

  override func viewDidLoad() {
    super.viewDidLoad()

    if let weather = data["weather"] as? [[String: Any]],
      let description = weather.first?["description"] as? String,
      let icon = weather.first?["icon"] as? String {
      label?.text = description

      let index = icon.index(icon.startIndex, offsetBy: 2)
      let iconName = icon.substring(to: index)
      if let image = UIImage(named: iconName) {
        imageView?.image = image
      }
    }
  }

}

extension DetailViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "Temperature"
    default:
      return "Wind"
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 7
    default:
      return 2
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    if indexPath.section == 0 {
      let key = temperatureKeys[indexPath.row]
      if let temperature = data["main"] as? [String: Any], let value = temperature[key] as? Double {
        cell.detailTextLabel?.text = "\(value)"
        cell.textLabel?.text = NSLocalizedString(key, comment: "")
      }
    }

    if indexPath.section == 1 {
      let key = windKeys[indexPath.row]
      if let wind = data["wind"] as? [String: Any], let value = wind[key] as? Double {
        cell.detailTextLabel?.text = "\(value)"
        cell.textLabel?.text = NSLocalizedString(key, comment: "")
      }
    }
    
    return cell
  }
}

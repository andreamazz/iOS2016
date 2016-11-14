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

  override func viewDidLoad() {
    super.viewDidLoad()
  }

}

extension DetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
  }
}

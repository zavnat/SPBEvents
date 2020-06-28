//
//  ViewController.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  var presentor: ViewToPresenterProtocol?
  var configurator: MainConfiguratorProtocol = MainConfigurator()
  
  var places: Array<Result> = Array()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    print("view did load")
    configurator.configure(with: self)
    presentor?.startFetchingPlaces()
  }
  
  @IBAction func addButtonPressed(_ sender: Any) {

  }
}

extension ViewController: PresenterToViewProtocol {
  func showPlaces(placesArray: Array<Result>) {
    places = placesArray
    tableView.reloadData()
  }
  
  func showError() {
    print("Error fetching places")
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return places.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = places[indexPath.row].title
    
    return cell
  }
}

//
//  NoteViewController.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, NotePresenterToViewProtocol {
  
  var presenter: NoteViewToPresenterProtocol?
  var configurator: NoteConfiguratorProtocol = NoteConfigurator()
  var id: Int?
  var dataToUI: DetailUIModel?
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var text: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configurator.configure(with: self)
    if let placeID = id {
      presenter?.startFetchingPlaces(with: placeID)
    }
  }
  
  func showDetail(place: DetailUIModel) {
    dataToUI = place
    DispatchQueue.main.async {
      self.label.text = self.dataToUI?.title
      self.text.text = self.dataToUI?.bodyText
    }
  }
}

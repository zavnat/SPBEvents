//
//  NoteViewController.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, NotePresenterToViewProtocol {
  
  var id: Int?
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var text: UITextView!
  
  var presenter: NoteViewToPresenterProtocol?
  var configurator: NoteConfiguratorProtocol = NoteConfigurator()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configurator.configure(with: self)
    presenter?.startFetchingPlaces()
  }
  
  
  
  
}

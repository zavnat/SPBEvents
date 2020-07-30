//
//  NoteViewController.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
  
  var id: Int?
  var place: Result? = nil
  
  @IBOutlet weak var textField: UITextView!
  override func viewDidLoad() {
    super.viewDidLoad()
//    textField.text = place?.title
  }
  
  
  
  
}

//
//  MainRouter.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import UIKit

class MainRouter: PresenterToRouterProtocol {
 
  var index = 0
  weak var paging: PagingViewController?
  
  
  func created(with index: Int){
//let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! NoteViewController
    viewController.performSegue(withIdentifier: "goToDetail", sender: nil)
  }
  
  weak var viewController: ViewController!
  
  init(viewController: ViewController) {
      self.viewController = viewController
  }

  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard segue.identifier == "showSecond" else { return }
      guard let destination = segue.destination as? NoteViewController else { return }
      destination.id = index

  }
}


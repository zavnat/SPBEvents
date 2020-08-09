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
  
  weak var viewController: ViewController!
  
  init(viewController: ViewController) {
    self.viewController = viewController
  }
  
  func created(with index: Int){
    viewController.performSegue(withIdentifier: "goToDetail", sender: nil)
  }
}


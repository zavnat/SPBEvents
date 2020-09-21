//
//  FavoriteRouter.swift
//  MyNotes
//
//  Created by admin on 17.08.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import UIKit

class FavoriteRouter: FavoritePresenterToRouterProtocol {
  
  weak var viewController: FavoriteController!
  
  init(viewController: FavoriteController) {
    self.viewController = viewController
  }
  
  func created(with index: Int){
    viewController.performSegue(withIdentifier: "favoriteDetail", sender: nil)
  }
}

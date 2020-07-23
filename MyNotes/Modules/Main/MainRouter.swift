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
  
  func prepare(for segue: UIStoryboardSegue, data: Result){
    let destinationVC = segue.destination as! NoteViewController
    NoteRouter.createNoteModule(with: data, destination: destinationVC)
  }
  


//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//      let destinationVC = segue.destination as! DetailViewController
//      
//      if let indexPath = tableView.indexPathForSelectedRow {
//        destinationVC.item = dataToUI[indexPath.row]
//      }
//
//
//}
}


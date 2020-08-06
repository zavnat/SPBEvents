//
//  NotePresenter.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import UIKit

class NotePresenter: NoteViewToPresenterProtocol, NoteInteractorToPresenterProtocol {
  
  var view: NotePresenterToViewProtocol?
  
  var interactor: NotePresenterToInteractorProtocol?
  
  var router: NotePresenterToRouterProtocol?
  
  
  
  func startFetchingPlaces() {
    print("start fetch from presenter")
    interactor?.getData()
  }
}

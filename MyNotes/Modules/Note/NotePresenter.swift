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
  
  func fetchSuccess(_ item: DetailModel) {
    let place = DetailUIModel(from: item)
    view?.showDetail(place: place)
  }
  
  func startFetchingPlaces(with id: Int) {
    interactor?.getData(String(id))
  }
  
  func noteButtonPressed(_ text: String, _ id: Int){
    interactor?.didGetNote(text, String(id))
  }
}

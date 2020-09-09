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
    let milisecondStart = item.dates[0].start
    let milisecondEnd = item.dates[0].end
    let dateStart = Date(milliseconds: Int64(milisecondStart))
    let dateEnd = Date(milliseconds: Int64(milisecondEnd))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMMM"
    
    let place = DetailUIModel(
      from: item,
      startDate: dateFormatter.string(from: dateStart),
      endDate: dateFormatter.string(from: dateEnd)
    )
    view?.showDetail(place: place)
  }
  
  func startFetchingPlaces(with id: Int) {
    interactor?.getData(String(id))
  }
  
  func noteButtonPressed(_ text: String?, _ id: Int){
    interactor?.didGetNote(text, String(id))
  }
  
  func likedButton(with id: Int) {
    interactor?.didGetLike(with: String(id))
  }
  
}

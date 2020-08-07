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
    print("data fetch success")
    print("")
    print(item.title)
    let place = DetailUIModel(from: item)
    view?.showDetail(place: place)
  }
  
  func startFetchingPlaces(with id: Int) {
    print("start fetch from presenter")
    interactor?.getData(String(id))
  }
}


struct DetailUIModel {
  let title: String
  let image: URL?
  var favorite: Bool
  let bodyText: String
}

extension DetailUIModel {
  init(from item: DetailModel) {
    title = item.title
    image = URL(string: item.images[0].image)
    favorite = false
    bodyText = item.bodyText
  }
}

//
//  FavoritePresenter.swift
//  MyNotes
//
//  Created by admin on 17.08.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import UIKit

class FavoritePresenter: FavoriteViewToPresenterProtocol {
  
  var view: FavoritePresenterToViewProtocol?
  var interactor: FavoritePresenterToInteractorProtocol?
  var router: FavoritePresenterToRouterProtocol?
  
  func startFetchingPlaces() {
    interactor?.getData()
  }
  
  func likedButtonTapped(with id: Int) {
    interactor?.likeButton(with: String(id))
  }
}

extension FavoritePresenter: FavoriteInteractorToPresenterProtocol{
  func dataFetchedSuccess(with data: [Liked]) {
    print("data fetch success")
    let items = data.map { FavoriteModel(item: $0) }
    view?.showPlaces(placesArray: items)
  }
}

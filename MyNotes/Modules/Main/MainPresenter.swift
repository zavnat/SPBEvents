//
//  MainPresenter.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import UIKit

class MainPresenter: ViewToPresenterProtocol {
  
  
  var view: PresenterToViewProtocol?
  
  var interactor: PresenterToInteractorProtocol?

  var router: PresenterToRouterProtocol?
  

  func startFetchingPlaces() {
    print("start fetch from presenter")
    interactor?.fetchData()
  }
  
}


extension MainPresenter: InteractorToPresenterProtocol{
    func dataFetchedSuccess(with data: Array<Result>) {
      print("data fetch success")
      view?.showPlaces(placesArray: data)
    }

    func noticeFetchFailed() {
      view?.showError()
    }

}


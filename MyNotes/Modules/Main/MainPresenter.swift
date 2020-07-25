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
  
  func didScroll(offsrtY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat){
    print("didscroll in presenter")
    interactor?.dataToNextPage(offsetY: offsrtY, contentHeight: contentHeight, frameHeight: frameHeight)
  }
  
  func startFetchingPlaces() {
    print("start fetch from presenter")
    interactor?.fetchData()
  }
}


extension MainPresenter: InteractorToPresenterProtocol{
    func dataFetchedSuccess(with data: [Result]) {
      print("data fetch success")
      let items = data.map { ViewModel(item: $0) }
      view?.showPlaces(placesArray: items)
    }

    func noticeFetchFailed() {
      view?.showError()
    }

}

struct ViewModel {
  let id: Int
  let title: String
  let image: URL?
}
extension ViewModel {
init(item: Result) {
  self.id = item.id
  self.title = item.title
  self.image = URL(string: item.images[0].image)
  }
}


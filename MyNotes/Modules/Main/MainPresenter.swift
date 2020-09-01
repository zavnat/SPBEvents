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
  
  var myRefreshControl: UIRefreshControl {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    return refreshControl
  }
  
  @objc private func refresh(sender: UIRefreshControl) {
    interactor?.refreshData()
    sender.endRefreshing()
  }
  
  // MARK: - ViewToPresenterProtocol Methods
  func startFetchingPlaces() {
    interactor?.getData()
  }
  
  func didScroll(offsrtY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat){
    interactor?.dataToNextPage(offsetY: offsrtY, contentHeight: contentHeight, frameHeight: frameHeight)
  }
  
  func cellSelected(_ index: Int) {
    router?.created(with: index)
  }
  
  func likedButtonTapped(with id: Int) {
    interactor?.didGetLike(with: String(id))
  }
  
  func notificationReceived() {
    interactor?.get()
  }
}


// MARK: - InteractorToPresenterProtocol Methods
extension MainPresenter: InteractorToPresenterProtocol{
  func dataFetchedSuccess(with data: [Note]) {
    let items = data.map { ViewModel(item: $0) }
    view?.showPlaces(placesArray: items)
  }
  
  func noticeFetchFailed() {
    view?.showError()
  }
}



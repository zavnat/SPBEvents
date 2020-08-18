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
  
  //MARK: - ViewToPresenterProtocol Methods
  
  func startFetchingPlaces() {
    interactor?.getData()
  }
  
  @objc private func refresh(sender: UIRefreshControl){
    interactor?.refresh()
    sender.endRefreshing()
  }
  
  func didScroll(offsrtY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat){
    print("didscroll in presenter")
    interactor?.dataToNextPage(offsetY: offsrtY, contentHeight: contentHeight, frameHeight: frameHeight)
  }
  
  func cellSelected(_ index : Int) {
    router?.created(with: index)
  }
  
  func likedButtonTapped(with id: Int) {
    interactor?.didGetLike(with: String(id))
  }
  
  func notificationReceived(){
    interactor?.get()
  }
}

//MARK: - InteractorToPresenterProtocol Methods
extension MainPresenter: InteractorToPresenterProtocol{
  func dataFetchedSuccess(with data: [Note]) {
    let items = data.map { ViewModel(item: $0) }
    view?.showPlaces(placesArray: items)
  }
  
  func noticeFetchFailed() {
    view?.showError()
  }
}

//MARK: - UIModel
struct ViewModel {
  let id: Int
  let title: String
  let image: URL?
  var favorite: Bool
}

extension ViewModel {
  init(item: Note) {
    self.id = Int(item.id!)!
    self.title = item.title!
    self.image = URL(string: item.image!)
    self.favorite = item.favorite
  }
}


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
//  var myRefreshControl: UIRefreshControl {
//    let refreshControl = UIRefreshControl()
//    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
//    return refreshControl
//  }
//
//  @objc private func refresh(sender: UIRefreshControl){
//    interactor?.refresh()
//    sender.endRefreshing()
//  }
  
//  func didScroll(offsrtY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat){
//    print("didscroll in presenter")
//    interactor?.dataToNextPage(offsetY: offsrtY, contentHeight: contentHeight, frameHeight: frameHeight)
//  }
//
  func startFetchingPlaces() {
    print("start fetch from presenter")
    interactor?.getData()
  }
//
//  func cellSelected(_ index : Int) {
//    router?.created(with: index)
//  }
//
//  func likedButtonTapped(with id: Int) {
//    interactor?.likeButton(with: String(id))
//  }
}


extension FavoritePresenter: FavoriteInteractorToPresenterProtocol{
  func dataFetchedSuccess(with data: [Liked]) {
    print("data fetch success")
    let items = data.map { FavoriteModel(item: $0) }
    view?.showPlaces(placesArray: items)
  }

  func noticeFetchFailed() {
//    view?.showError()
  }
}

struct FavoriteModel {
  let id: Int
  let title: String
  let image: URL?
  var favorite: Bool
}
extension FavoriteModel {
  init(item: Liked) {
    self.id = Int(item.id!)!
    self.title = item.title!
    self.image = URL(string: item.image!)
    self.favorite = true
  }
}

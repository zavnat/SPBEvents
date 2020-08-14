//
//  MainProtocols.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import UIKit

protocol InteractorToPresenterProtocol: class {
  func dataFetchedSuccess(with data: [Note])
  func noticeFetchFailed()
}

protocol PresenterToInteractorProtocol: class {
  var presenter:InteractorToPresenterProtocol? {get set}
  func dataToNextPage(offsetY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat)
  func getData()
  func likeButton(with stringId: String)
  func refresh()
}

protocol PresenterToViewProtocol: class {
  func showPlaces(placesArray: [ViewModel])
  func showError()
}

protocol ViewToPresenterProtocol: class {
  var view: PresenterToViewProtocol? {get set}
  var interactor: PresenterToInteractorProtocol? {get set}
  var router: PresenterToRouterProtocol? {get set}
  func startFetchingPlaces()
  func didScroll(offsrtY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat)
  func cellSelected(_ index: Int)
  func likedButtonTapped(with id: Int)
  var myRefreshControl: UIRefreshControl {get }
}

protocol PresenterToRouterProtocol: class {
  func created(with index: Int)
}

protocol MainConfiguratorProtocol: class {
  func configure(with viewController: ViewController)
}


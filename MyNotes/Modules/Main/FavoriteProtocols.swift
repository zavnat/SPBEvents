

import Foundation
import UIKit

protocol FavoriteInteractorToPresenterProtocol: class {
  func dataFetchedSuccess(with data: [Liked])
  func noticeFetchFailed()
}

protocol FavoritePresenterToInteractorProtocol: class {
  var presenter:FavoriteInteractorToPresenterProtocol? {get set}
//  func dataToNextPage(offsetY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat)
  func getData()
  func likeButton(with stringId: String)
//  func refresh()
}

protocol FavoritePresenterToViewProtocol: class {
  func showPlaces(placesArray: [FavoriteModel])
//  func showError()
}

protocol FavoriteViewToPresenterProtocol: class {
  var view: FavoritePresenterToViewProtocol? {get set}
  var interactor: FavoritePresenterToInteractorProtocol? {get set}
  var router: FavoritePresenterToRouterProtocol? {get set}
  func startFetchingPlaces()
//  func didScroll(offsrtY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat)
//  func cellSelected(_ index: Int)
  func likedButtonTapped(with id: Int)
//  var myRefreshControl: UIRefreshControl {get }
}

protocol FavoritePresenterToRouterProtocol: class {
  func created(with index: Int)
}

protocol FavoriteConfiguratorProtocol: class {
  func configure(with viewController: FavoriteController)
}


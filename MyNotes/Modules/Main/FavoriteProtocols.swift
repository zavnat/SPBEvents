

import Foundation
import UIKit

protocol FavoriteInteractorToPresenterProtocol: class {
  func dataFetchedSuccess(with data: [Liked])
}

protocol FavoritePresenterToInteractorProtocol: class {
  var presenter: FavoriteInteractorToPresenterProtocol? {get set}
  func getData()
  func likeButton(with stringId: String)
}

protocol FavoritePresenterToViewProtocol: class {
  func showPlaces(placesArray: [FavoriteModel])
}

protocol FavoriteViewToPresenterProtocol: class {
  var view: FavoritePresenterToViewProtocol? {get set}
  var interactor: FavoritePresenterToInteractorProtocol? {get set}
  var router: FavoritePresenterToRouterProtocol? {get set}
  func startFetchingPlaces()
  //  func cellSelected(_ index: Int)
  func likedButtonTapped(with id: Int)
}

protocol FavoritePresenterToRouterProtocol: class {
  func created(with index: Int)
}

protocol FavoriteConfiguratorProtocol: class {
  func configure(with viewController: FavoriteController)
}


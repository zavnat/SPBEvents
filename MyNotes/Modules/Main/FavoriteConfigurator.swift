

import Foundation
import UIKit

class FavoriteConfigurator: FavoriteConfiguratorProtocol {
  
  func configure(with controller: FavoriteController) {
    let presenter: FavoriteViewToPresenterProtocol & FavoriteInteractorToPresenterProtocol = FavoritePresenter()
    let interactor: FavoritePresenterToInteractorProtocol = FavoriteInteractor()
    let router: FavoritePresenterToRouterProtocol = FavoriteRouter(viewController: controller)

    controller.presenter = presenter
    presenter.view = controller
    presenter.router = router
    presenter.interactor = interactor
    interactor.presenter = presenter
  }
}

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
  func dataFetchedSuccess(with data: Array<Result>)
  func noticeFetchFailed()
}

protocol PresenterToInteractorProtocol: class {
  var presenter:InteractorToPresenterProtocol? {get set}
  func fetchData()
}

protocol PresenterToViewProtocol: class {
  func showPlaces(placesArray: Array<Result>)
  func showError()
}

protocol ViewToPresenterProtocol: class {
  
  var view: PresenterToViewProtocol? {get set}
  var interactor: PresenterToInteractorProtocol? {get set}
  var router: PresenterToRouterProtocol? {get set}
  func startFetchingPlaces()
  //func showNoteViewController(navigationController: UINavigationController)

}

protocol PresenterToRouterProtocol: class {
  func prepare()
}

protocol MainConfiguratorProtocol: class {
    func configure(with viewController: ViewController)
}

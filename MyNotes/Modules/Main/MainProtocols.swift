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
  func dataFetchedSuccess(with data: [Result])
  func noticeFetchFailed()
}

protocol PresenterToInteractorProtocol: class {
  var presenter:InteractorToPresenterProtocol? {get set}
  func fetchData()
  func dataToNextPage(offsetY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat)
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

}

protocol PresenterToRouterProtocol: class {
//  func prepare(for segue: UIStoryboardSegue, data: Result)
  func created(with index: Int)
}

protocol MainConfiguratorProtocol: class {
    func configure(with viewController: ViewController)
}


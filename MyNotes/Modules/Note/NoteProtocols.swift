//
//  NoteProtocols.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import UIKit

protocol NoteInteractorToPresenterProtocol: class {
  func fetchSuccess(_ item: DetailModel)
}

protocol NotePresenterToInteractorProtocol: class {
  var presenter: NoteInteractorToPresenterProtocol? {get set}
  func getData(_ id: String)
  func didGetNote(_ text: String, _ id: String)
  func didGetLike(with id: String)
}

protocol NotePresenterToViewProtocol: class {
  func showDetail(place: DetailUIModel)
}

protocol NoteViewToPresenterProtocol: class {
  var view: NotePresenterToViewProtocol? {get set}
  var interactor: NotePresenterToInteractorProtocol? {get set}
  var router: NotePresenterToRouterProtocol? {get set}
  func startFetchingPlaces(with id: Int)
  func noteButtonPressed(_ text: String, _ id: Int)
  func likedButton(with id: Int)
}

protocol NotePresenterToRouterProtocol: class {
}

protocol NoteConfiguratorProtocol: class {
  func configure(with viewController: NoteViewController)
}


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
//  func dataFetchedSuccess(with data: [Note])
//  func noticeFetchFailed()
  func fetchSuccess(_ item: DetailModel)
}

protocol NotePresenterToInteractorProtocol: class {
  var presenter: NoteInteractorToPresenterProtocol? {get set}
////  func fetchData()
//  func dataToNextPage(offsetY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat)
  func getData(_ id: String)
  func didGetNote(_ text: String)
//
//  func likeButton(with stringId: String)
}

protocol NotePresenterToViewProtocol: class {
  func showDetail(place: DetailUIModel)
//  func showError()
}

protocol NoteViewToPresenterProtocol: class {
  
  var view: NotePresenterToViewProtocol? {get set}
  var interactor: NotePresenterToInteractorProtocol? {get set}
  var router: NotePresenterToRouterProtocol? {get set}
  func startFetchingPlaces(with id: Int)
  func noteButtonPressed(_ text: String)
//  func didScroll(offsrtY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat)
//  func cellSelected(_ index: Int)
////  func load()
//  func likedButtonTapped(with id: Int)

}

protocol NotePresenterToRouterProtocol: class {
////  func prepare(for segue: UIStoryboardSegue, data: Result)
//  func created(with index: Int)
}

protocol NoteConfiguratorProtocol: class {
    func configure(with viewController: NoteViewController)
}


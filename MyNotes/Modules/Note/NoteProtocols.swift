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
//  func fetchFromDatabaseSuccess(_ items: [Note])
}

protocol NotePresenterToInteractorProtocol: class {
  var presenter: NoteInteractorToPresenterProtocol? {get set}
////  func fetchData()
//  func dataToNextPage(offsetY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat)
  func getData()
//
//  func likeButton(with stringId: String)
}

protocol NotePresenterToViewProtocol: class {
//  func showPlaces(placesArray: [ViewModel])
//  func showError()
}

protocol NoteViewToPresenterProtocol: class {
  
  var view: NotePresenterToViewProtocol? {get set}
  var interactor: NotePresenterToInteractorProtocol? {get set}
  var router: NotePresenterToRouterProtocol? {get set}
  func startFetchingPlaces()
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


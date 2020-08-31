//
//  FavoriteInteractor.swift
//  MyNotes
//
//  Created by admin on 17.08.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation

class FavoriteInteractor: FavoritePresenterToInteractorProtocol {
  
  var dataServise = DataServise()
  var presenter: FavoriteInteractorToPresenterProtocol?
  
  func getData(){
    dataServise.fetchFavoritesData { [weak self] items in
      guard let self = self else { return }
      self.presenter?.dataFetchedSuccess(with: items)
    }
  }
  
  func likeButton(with stringId: String){
    dataServise.updateDataFromFavorites(id: stringId)
  }
  
//  func didGetNote(_ text: String) {
//    dataServise.addNoteToData(text)
//  }
}

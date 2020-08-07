//
//  NoteInteractor.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import Alamofire

class NoteInteractor: NotePresenterToInteractorProtocol {
  
  var dataServise = DataServise()
  var presenter: NoteInteractorToPresenterProtocol?
  
  func getData(_ id: String) {
    fetchPlaceDetail(id)
  }
  
  private func fetchPlaceDetail(_ id: String) {
    print("fetch detail data")
    let detailURL = "https://kudago.com/public-api/v2.0/places/\(id)"
    
    Alamofire.request(detailURL, method: .get).response { (response) in
      guard let data = response.data else { return }
      let decoder = JSONDecoder()
      do {
        let item = try decoder.decode(DetailModel.self, from: data)
        self.presenter?.fetchSuccess(item)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

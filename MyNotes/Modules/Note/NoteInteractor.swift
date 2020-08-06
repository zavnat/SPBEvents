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
  
  func getData() {
    fetchPlaceDetail()
  }
  
  private func fetchPlaceDetail() {
    print("fetch data")
    let detailURL = "https://kudago.com/public-api/v2.0/places"
    
    let parameters : [String : String] = [
      "id" : "\(12271)"
    ]
    
    Alamofire.request(detailURL, method: .get, parameters: parameters).response { (response) in
      guard let data = response.data else { return }
      print(data.count)
      let decoder = JSONDecoder()
      do {
        let item = try decoder.decode(PlaceDetail.self, from: data)
        //        print(places.subway)
        //     self.presenter?.dataFetchedSuccess(with: places.results)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
}

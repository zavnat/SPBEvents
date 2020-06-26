//
//  MainInteractor.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import Alamofire

class MainInteractor {
  
  var presenter: InteractorToPresenterProtocol?
  
  let placesURL = "https://kudago.com/public-api/v1.4/places"
  var currentPage = 1
  
  func fetchData() {
    
    let parameters : [String : String] = [
    "location" : "spb",
    "page" : "\(currentPage)"
  ]
    
    
    Alamofire.request(placesURL, method: .get, parameters: parameters).response { (response) in
      //print(response)
      guard let data = response.data else { return }
      let decoder = JSONDecoder()
      do {
        let places = try decoder.decode(Places.self, from: data)
        self.presenter?.noticeFetchedSuccess(with: places.results)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

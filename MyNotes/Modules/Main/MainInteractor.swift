//
//  MainInteractor.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import Alamofire

class MainInteractor: PresenterToInteractorProtocol {
  
  var presenter: InteractorToPresenterProtocol?
  
  let placesURL = "https://kudago.com/public-api/v1.4/places"
  var currentPage = 2
  
  @objc func fetchData() {
    print("fetch data")
    
    let parameters : [String : String] = [
    "location" : "spb",
    "page" : "\(currentPage)"
  ]
    
    
    Alamofire.request(placesURL, method: .get, parameters: parameters).response { (response) in
      //print(response)
      guard let data = response.data else { return }
      print(data.count)
      let decoder = JSONDecoder()
      do {
        let places = try decoder.decode(Places.self, from: data)
        print(places.results)
     self.presenter?.dataFetchedSuccess(with: places.results)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
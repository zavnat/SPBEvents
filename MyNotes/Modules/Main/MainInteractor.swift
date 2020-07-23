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
  
  let placesURL = "https://kudago.com/public-api/v2.0/places"
  var currentPage = 2
  
  func fetchData() {
    print("fetch data")
    
    let parameters : [String : String] = [
      "location" : "spb",
      "page" : "\(currentPage)",
      "fields" : "id,slug,images,title"
    ]
    
    
    Alamofire.request(placesURL, method: .get, parameters: parameters).response { (response) in
      //print(response)
      guard let data = response.data else { return }
      print(data.count)
      let decoder = JSONDecoder()
      do {
        let places = try decoder.decode(Places.self, from: data)
        
     self.presenter?.dataFetchedSuccess(with: places.results)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

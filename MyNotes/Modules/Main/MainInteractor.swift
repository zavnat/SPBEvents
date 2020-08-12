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
  
  var dataServise = DataServise()
  var presenter: InteractorToPresenterProtocol?
  var fetchingMore = false
  
  let placesURL = "https://kudago.com/public-api/v2.0/places"
  var currentPage = 1
  
  func dataToNextPage(offsetY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat){
    if offsetY > contentHeight - frameHeight * 2 {
      if !fetchingMore && currentPage < 5 {
        self.fetchData()
      }
    }
  }
  
  func getData(){
    loadData()
    fetchData()
  }
  
  func loadData(){
    dataServise.loadDataFromDatabase { [weak self] items in
      guard let self = self else { return }
      self.presenter?.dataFetchedSuccess(with: items)
    }
  }
  
  private func fetchData() {
    
    fetchingMore = true
    print("fetch data")
    
    let parameters : [String : String] = [
      "location" : "spb",
      "page" : "\(currentPage)",
      "fields" : "id,slug,images,title"
    ]
    
    
    Alamofire.request(placesURL, method: .get, parameters: parameters).response { (response) in
      guard let data = response.data else { return }
      print(data.count)
      let decoder = JSONDecoder()
      do {
        let places = try decoder.decode(Places.self, from: data)
        
        if places.results.count > 0 {
          self.dataServise.deleteAllRecords()
        }
        
        self.currentPage += 1
        self.fetchingMore = false
      
        self.dataServise.saveDataToDatabase(items: places.results)
        self.loadData()
        
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  //  func load (){
  //    dataServise.fetchData{ [weak self] items in
  //    guard let self = self else { return }
  //      self.presenter?.fetchFromDatabaseSuccess(items)
  //    }
  //  }
  
  func likeButton(with stringId: String){
    dataServise.updateData(id: stringId)
  }
}

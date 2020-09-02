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
  let placesURL = "https://kudago.com/public-api/v2.0/events"
  var currentPage = 1
  
  func dataToNextPage(offsetY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat){
    if offsetY > contentHeight - frameHeight * 2 {
      if !fetchingMore && currentPage < 10 {
        self.fetchNetworkData()
      }
    }
  }
  
  func refreshData() {
    currentPage = 1
    fetchNetworkData()
  }
  
  func getData() {
    if currentPage == 1 {
      loadDataFromDatabase()
      fetchNetworkData()
    } else {
      fetchNetworkData()
    }
  }
  
  func didGetLike(with stringId: String){
    dataServise.updateData(id: stringId)
  }
  
  func get() {
    loadDataFromDatabase()
  }
  
  private func loadDataFromDatabase() {
    dataServise.fetchData { [weak self] items in
      guard let self = self else { return }
      self.presenter?.dataFetchedSuccess(with: items)
    }
  }
  
  private func fetchNetworkData() {
    fetchingMore = true
    let parameters: [String: String] = [
      "location": "spb",
      "page": "\(currentPage)",
      "fields": "id,slug,images,title"
    ]
    Alamofire.request(placesURL, method: .get, parameters: parameters).response { (response) in
      guard let data = response.data else { return }
      print(data.count)
      let decoder = JSONDecoder()
      do {
        let places = try decoder.decode(Places.self, from: data)
        self.fetchingMore = false
        self.dataServise.saveDataToDatabase(items: places.results, page: self.currentPage)
        self.loadDataFromDatabase()
        self.currentPage += 1
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
}

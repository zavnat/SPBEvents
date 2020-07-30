//
//  MainInteractor.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class MainInteractor: PresenterToInteractorProtocol {
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
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
  
  func fetchData() {
    
      fetchingMore = true
      print("fetch data")
    print(currentPage)
    
      
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
          

          self.currentPage += 1
          self.fetchingMore = false
          
          self.presenter?.dataFetchedSuccess(with: places.results)
        } catch {
          print(error.localizedDescription)
        }
      }
    }
  
  
  func saveDataToDatabase(with text: String, date: String, type: String, comment: String){
    let note = Note(context: context)
    note.id
    
    
    
    do{
      try  context.save()
    }catch{
      
    }
  }
}

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
//  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
          
          self.dataServise.saveDataToDatabase(items: places.results)
          
          self.presenter?.dataFetchedSuccess(with: places.results)
        } catch {
          print(error.localizedDescription)
        }
      }
    }
  
//  func save() {
//    dataServise.saveDataToDatabase(with: <#T##String#>, title: <#T##String#>, image: <#T##String#>)
//  }
  
//  
//  func saveDataToDatabase(with id: String, title: String, image: String){
//    let note = Note(context: context)
//    note.id = id
//    note.title = title
//    note.image = image
//    
//    do{
//      try  context.save()
//    }catch{
//      print("Error save data from context")
//    }
//  }
//  
//  func fetchFromDatabase () {
//    let request: NSFetchRequest<Note> = Note.fetchRequest()
////    let sort = NSSortDescriptor(key: "name", ascending: false)
////    request.sortDescriptors = [sort]
//    do{
//      let data = try context.fetch(request)
//      print("Success load data from database")
////      completion(data)
//      
//    }catch {
//      print("Error context fetch data")
//    }
//  }
  
}

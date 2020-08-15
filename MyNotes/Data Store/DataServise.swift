//
//  DataServise.swift
//  MyNotes
//
//  Created by admin on 03.08.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataServise {
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var selfID = 0
  func saveDataToDatabase(items: [Result], page: Int){
    
    if page == 1 {
      selfID = 0
    }
    
    var notesList = [Note]()
    
    for item in items {
      let note = Note(context: self.context)
      note.id = String(item.id)
      print(item.id)
      note.title = item.title
      note.favorite = false
      note.image = item.images[0].image
      note.favorite = false
      selfID += 1
      note.selfID = Int16(selfID)
      
      notesList.append(note)
    }
    
    
    do{
      try  context.save()
      print("Success save data to database")
    }catch{
      print("Error save data from context")
    }
  }
  
  func checkFavorite(){
    
  }
  //  func fetchFavoritesData () {
  //    let type = true
  //    let request: NSFetchRequest<Note> = Note.fetchRequest()
  //    request.predicate = NSPredicate(format: "favorite = %@", type)
  ////          let sort = NSSortDescriptor(key: "name", ascending: false)
  //      //    request.sortDescriptors = [sort]
  //      do{
  //        let data = try context.fetch(request)
  //        print("Success load data from database")
  ////              completion(data)
  //
  //      }catch {
  //        print("Error context fetch data")
  //      }
  //    }
  
  
  
  func loadDataFromDatabase (completion: @escaping ([Note]) -> ()) {
    let request: NSFetchRequest<Note> = Note.fetchRequest()
    let sort = NSSortDescriptor(key: "selfID", ascending: true)
    request.sortDescriptors = [sort]
    do{
      let data = try context.fetch(request)
      
      print("Success load data from database")
      completion(data)
      
    }catch {
      print("Error context fetch data")
    }
  }
  
  
  func deleteAllRecords() {
    
    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
    
    do {
      print("Delete all items from database")
      try context.execute(deleteRequest)
      try context.save()
      
    } catch {
      print ("There was an error")
    }
  }
  
  func updateData(id: String){
    let request : NSFetchRequest<Note> = Note.fetchRequest()
    request.predicate = NSPredicate(format: "id = %@", id)
    do{
      let data = try context.fetch(request)
      
      //      print("")
      //      print("Success load data from database")
      //      print(data[0].favorite)
      
      data[0].favorite = !data[0].favorite
      
      do{
        try  context.save()
        print("Success save data to database")
      }catch{
        print("Error save data from context")
      }
      addToFavorite(data: data[0])
    }catch {
      print("Error context fetch data")
    }
  }
  
  
  func addToFavorite(data: Note){
    let favorite = Liked(context: self.context)
    favorite.id = data.id
    favorite.image = data.image
    favorite.title = data.title
    do{
      try  context.save()
      print("Success save data to database")
    }catch{
      print("Error save data from context")
    }
  }
  
  func deleteFromFavorite(_ id: String){
    let fetchRequest: NSFetchRequest<Liked> = Liked.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id = %@", id)

    do {
        let objects = try context.fetch(fetchRequest)
        for object in objects {
            context.delete(object)
        }
        try context.save()
    } catch {
        print("Error delete object from Favorite")
    }
    
  }
}


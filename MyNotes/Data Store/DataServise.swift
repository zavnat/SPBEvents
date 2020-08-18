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
  var favoriteID = 0
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
      note.favorite = checkFavorite(item: item) ?? false
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
  
  func checkFavorite(item: Result) -> Bool?{
    let id = String(item.id)
    let request: NSFetchRequest<Liked> = Liked.fetchRequest()
    request.predicate = NSPredicate(format: "id = %@", id)
    
    do {
        let objects = try context.fetch(request)
      if objects.isEmpty {
        return false
      } else {
        return true
      }
    } catch {
       
    }
    return nil
  }
  
    func fetchFavoritesData (completion: @escaping ([Liked]) -> ()) {
      let request: NSFetchRequest<Liked> = Liked.fetchRequest()
//      request.predicate = NSPredicate(format: "favorite = %@", type)
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
      
      data[0].favorite = !data[0].favorite
      
      do{
        try  context.save()
        print("Success save data to database")
      }catch{
        print("Error save data from context")
      }
      
      if data[0].favorite {
        addToFavorite(data: data[0])
      } else {
        deleteFromFavorite(id)
      }
      let nc = NotificationCenter.default
      nc.post(name: .FavoriteChanged, object: nil)
      
    }catch {
      print("Error context fetch data")
    }
  }
  
  func updateDataFromFavorites(id: String){
    deleteFromFavorite(id)
    
    let request : NSFetchRequest<Note> = Note.fetchRequest()
    request.predicate = NSPredicate(format: "id = %@", id)
    do{
      let data = try context.fetch(request)
      
      data[0].favorite = !data[0].favorite
      
      do{
        try  context.save()
        print("Success save data to database")
      }catch{
        print("Error save data from context")
      }
      let nc = NotificationCenter.default
      nc.post(name: .MainChanged, object: nil)
      
      //      let nc = NotificationCenter.default
      //      nc.post(name: .FavoriteChanged, object: nil)
      //
    }catch {
      print("Error context fetch data")
    }
  }
  
  
  
  
  func addToFavorite(data: Note){
    
    let favorite = Liked(context: self.context)
    favorite.id = data.id
    favorite.image = data.image
    favorite.title = data.title
    favoriteID += 1
    favorite.selfID = Int16(favoriteID)
    do{
      try  context.save()
      print("Success add to Favorite")
    }catch{
      print("Error save data to Favorite")
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
        print("Success delete to Favorite")
    } catch {
        print("Error delete object from Favorite")
    }
    
  }
}


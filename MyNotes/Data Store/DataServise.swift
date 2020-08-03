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
  
  func saveDataToDatabase(items: [Result]){
    
    var notesList = [Note]()
    
    for item in items {
      let note = Note(context: self.context)
      note.id = String(item.id)
      note.title = item.title
      note.favorite = false
      note.image = item.images[0].image

      notesList.append(note)
    }
    
//    let note = Note(context: context)
//    note.id = id
//    note.title = title
//    note.image = image
//    note.favorite = favorite
    
    do{
      try  context.save()
      print("Success save data to database")
    }catch{
      print("Error save data from context")
    }
  }
  
  func fetchFavoritesData () {
    let type = true
    let request: NSFetchRequest<Note> = Note.fetchRequest()
    request.predicate = NSPredicate(format: "favorite = %@", type)
//          let sort = NSSortDescriptor(key: "name", ascending: false)
      //    request.sortDescriptors = [sort]
      do{
        let data = try context.fetch(request)
        print("Success load data from database")
        //      completion(data)
        
      }catch {
        print("Error context fetch data")
      }
    }
  
  
  
  func fetchData (completion: @escaping ([Note]) -> ()) {
    let request: NSFetchRequest<Note> = Note.fetchRequest()
    //    let sort = NSSortDescriptor(key: "name", ascending: false)
    //    request.sortDescriptors = [sort]
    do{
      let data = try context.fetch(request)
      print("Success load data from database")
            completion(data)
      
    }catch {
      print("Error context fetch data")
    }
  }
}


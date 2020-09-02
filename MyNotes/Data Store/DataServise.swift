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
  
  
  // MARK: - Save Methods
  func saveDataToDatabase(items: [Result], page: Int) {
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
      note.noteText = haveNoteText(for: item)
      
      notesList.append(note)
    }
    if page == 1 {
      deleteAllRecords()
    }
    saveContext()
  }
  
  
  private func addToFavorite(data: Note){
    let favorite = Liked(context: self.context)
    favorite.id = data.id
    favorite.image = data.image
    favorite.title = data.title
    favoriteID += 1
    favorite.selfID = Int16(favoriteID)
    favorite.noteText = data.noteText
    saveContext()
  }
  
  
  private func saveContext() {
    do {
      try  context.save()
      print("Success save data to database")
    } catch {
      print("Error save data to datbase")
    }
  }
  
  
  // MARK: - Check Methods
  private func checkFavorite(item: Result) -> Bool? {
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
  
  private func haveNoteText(for item: Result) -> String? {
    let id = String(item.id)
    let request: NSFetchRequest<Note> = Note.fetchRequest()
    request.predicate = NSPredicate(format: "id = %@", id)
    do {
      let objects = try context.fetch(request)
      return objects[0].noteText
    } catch {
    }
    return nil
  }
  
  
  // MARK: - Change Methods
  func addNoteToData(_ note: String, _ id: String){
    let request: NSFetchRequest<Note> = Note.fetchRequest()
    request.predicate = NSPredicate(format: "id = %@", id)
    let requestLiked: NSFetchRequest<Liked> = Liked.fetchRequest()
    requestLiked.predicate = NSPredicate(format: "id = %@", id)
    do {
      let data = try context.fetch(request)
      data[0].noteText = note
      let likeData = try context.fetch(requestLiked)
      if likeData.count > 0 {
        likeData[0].noteText = note
      }
      try context.save()
      let nc = NotificationCenter.default
      nc.post(name: .MainChanged, object: nil)
      nc.post(name: .FavoriteChanged, object: nil)
    } catch {
      print("Error save note")
    }
  }
  
  func updateDataFromDetail(id: String) {
    updateData(id: id)
    let nc = NotificationCenter.default
    nc.post(name: .MainChanged, object: nil)
  }
  
  func updateData(id: String) {
    let request : NSFetchRequest<Note> = Note.fetchRequest()
    request.predicate = NSPredicate(format: "id = %@", id)
    do {
      let data = try context.fetch(request)
      data[0].favorite = !data[0].favorite
      try context.save()
      
      if data[0].favorite {
        addToFavorite(data: data[0])
      } else {
        deleteFromFavorites(id)
      }
      let nc = NotificationCenter.default
      nc.post(name: .FavoriteChanged, object: nil)
    } catch {
      print("Error update data")
    }
  }
  
  func updateDataFromFavorites(id: String) {
    deleteFromFavorites(id)
    
    let request : NSFetchRequest<Note> = Note.fetchRequest()
    request.predicate = NSPredicate(format: "id = %@", id)
    do {
      let data = try context.fetch(request)
      data[0].favorite = !data[0].favorite
      try context.save()
      let nc = NotificationCenter.default
      nc.post(name: .MainChanged, object: nil)
    }catch {
      print("Error update data")
    }
  }
  
  
  // MARK: - Load Methods
  func fetchFavoritesData (completion: @escaping ([Liked]) -> ()) {
    let request: NSFetchRequest<Liked> = Liked.fetchRequest()
    let sort = NSSortDescriptor(key: "selfID", ascending: true)
    request.sortDescriptors = [sort]
    do {
      let data = try context.fetch(request)
      completion(data)
    } catch {
      print("Error fetch Liked")
    }
  }
  
  func fetchData (completion: @escaping ([Note]) -> ()) {
    let request: NSFetchRequest<Note> = Note.fetchRequest()
    let sort = NSSortDescriptor(key: "selfID", ascending: true)
    request.sortDescriptors = [sort]
    do {
      let data = try context.fetch(request)
      completion(data)
    } catch {
      print("Error fetch data")
    }
  }
  
  
  // MARK: - Delete Methods
  func deleteAllRecords() {
    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
    do {
      try context.execute(deleteRequest)
      try context.save()
    } catch {
      print ("Error delete all items from database")
    }
  }
  
  private func deleteFromFavorites(_ id: String) {
    let fetchRequest: NSFetchRequest<Liked> = Liked.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id = %@", id)
    do {
      let objects = try context.fetch(fetchRequest)
      for object in objects {
        context.delete(object)
      }
      try context.save()
    } catch {
      print("Error delete object from Favorites")
    }
  }
  
}


//
//  NoteRouter.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation

class NoteRouter {
  static func createNoteModule(with place: Result, destination: NoteViewController) {
    destination.place = place
  }
}

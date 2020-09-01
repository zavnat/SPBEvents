//
//  NoteConfigurator.swift
//  MyNotes
//
//  Created by admin on 06.08.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import UIKit

class NoteConfigurator: NoteConfiguratorProtocol {
  
  func configure(with controller: NoteViewController) {
    let presenter: NoteViewToPresenterProtocol & NoteInteractorToPresenterProtocol = NotePresenter()
    let interactor: NotePresenterToInteractorProtocol = NoteInteractor()
    let router: NotePresenterToRouterProtocol = NoteRouter()
    
    controller.presenter = presenter
    presenter.view = controller
    presenter.router = router
    presenter.interactor = interactor
    interactor.presenter = presenter
  }
}

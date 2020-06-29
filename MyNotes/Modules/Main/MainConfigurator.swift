//
//  MainConfigurator.swift
//  MyNotes
//
//  Created by admin on 27.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import UIKit

class MainConfigurator: MainConfiguratorProtocol {
    
    func configure(with controller: ViewController) {
//        let presenter = MainPresenter(view: controller)
//        let interactor = MainInteractor(presenter: presenter)
//        let router = MainRouter(viewController: controller)
        
//        controller.presenter = presenter
//        presenter.interactor = interactor
//        presenter.router = router
//        presenter.currencyPickerView = controller.currencyPickerView
//        controller.currencyPickerView.delegate = presenter
      
      let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = MainPresenter()
      let interactor: PresenterToInteractorProtocol = MainInteractor()
      let router: PresenterToRouterProtocol = MainRouter(viewController: controller)
      
      controller.presenter = presenter
      presenter.view = controller
      presenter.router = router
      presenter.interactor = interactor
      interactor.presenter = presenter
    }
}


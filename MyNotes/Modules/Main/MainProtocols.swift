//
//  MainProtocols.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation

protocol InteractorToPresenterProtocol: class {
  func noticeFetchedSuccess(with: Array<Result>)
    func noticeFetchFailed()
}

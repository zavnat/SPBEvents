//
//  NoteProtocols.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation

protocol ViewToPresenterMovieProtocol:class{
    
//    var view: PresenterToViewMovieProtocol? {get set}
//    var interactor: PresenterToInteractorMovieProtocol? {get set}
//    var router: PresenterToRouterMovieProtocol? {get set}
//    func startFetchingMovie()

}

protocol PresenterToViewMovieProtocol:class {
    
//    func onMovieResponseSuccess(movieModelArrayList:Array<MovieModel>)
//    func onMovieResponseFailed(error:String)
    
}

protocol PresenterToRouterMovieProtocol:class {
    
//    static func createMovieModule()->MovieViewController

}

protocol PresenterToInteractorMovieProtocol:class {
    
//    var presenter:InteractorToPresenterMovieProtocol? {get set}
//    func fetchMovie()
    
}

protocol InteractorToPresenterMovieProtocol:class {
    
//    func movieFetchSuccess(movieList:Array<MovieModel>)
//    func movieFetchFailed()
//    
}

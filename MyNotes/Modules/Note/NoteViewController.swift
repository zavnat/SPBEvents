//
//  NoteViewController.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import Kingfisher

class NoteViewController: UIViewController, NotePresenterToViewProtocol {
  
  var presenter: NoteViewToPresenterProtocol?
  var configurator: NoteConfiguratorProtocol = NoteConfigurator()
  var id: Int?
  
  var dataToUI: DetailUIModel?
  
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var text: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(id ?? 0)
    configurator.configure(with: self)
    if let placeID = id {
      presenter?.startFetchingPlaces(with: placeID)
      spinner.startAnimating()
    }
  }
  
  func showDetail(place: DetailUIModel) {
    dataToUI = place
    print(dataToUI!)
   
    let string = self.dataToUI?.bodyText ?? ""

    DispatchQueue.main.async {
      self.spinner.stopAnimating()
      
      self.image.kf.setImage(with: self.dataToUI?.image!)
      self.label.text = self.dataToUI?.title
      self.text.text = string.withoutHtmlTags
    }
  }
}


extension String {
    var withoutHtmlTags: String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options:
    .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with:
    "", options:.regularExpression, range: nil)
    }
}

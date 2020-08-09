//
//  NoteViewController.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import Kingfisher

class NoteViewController: UIViewController {
  
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
  image.layer.cornerRadius = 30
  image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    configurator.configure(with: self)
    if let placeID = id {
      presenter?.startFetchingPlaces(with: placeID)
      spinner.startAnimating()
    }
  }
}

//MARK: - NotePresenterToViewProtocol Methods
extension NoteViewController: NotePresenterToViewProtocol {
  func showDetail(place: DetailUIModel) {
    dataToUI = place
    let string = self.dataToUI?.bodyText ?? ""
    
    DispatchQueue.main.async {
      self.spinner.stopAnimating()
      self.image.kf.setImage(with: self.dataToUI?.image!)
      self.label.text = self.dataToUI?.title.capitalized
      self.text.text = string.withoutHtmlTags
    }
  }
}

//MARK: - Extension String
extension String {
    var withoutHtmlTags: String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options:
    .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with:
    "", options:.regularExpression, range: nil)
    }
}


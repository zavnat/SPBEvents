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
  var favorite: Bool?
  var noteText: String?
  var dataToUI: DetailUIModel?
  
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var text: UITextView!
  @IBOutlet weak var note: UILabel!
  
  @IBOutlet weak var gradient: UIView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    image.layer.cornerRadius = 30
    image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    configurator.configure(with: self)
    spinner.startAnimating()
    likeButtonSettings()
    gradient.fadeView()
    if let placeID = id {
      presenter?.startFetchingPlaces(with: placeID)
    }
  }
  
  @IBAction func backButtonTapped(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func likeButtonTapped(_ sender: UIButton) {
    guard let itemID = id else {return}
    guard let liked = favorite else {return}
    favorite = !liked
    likeButtonSettings()
    presenter?.likedButton(with: itemID)
  }
  
  @IBAction func editButtonTapped(_ sender: UIButton) {
    var textField = UITextField()
    let alert = UIAlertController(title: "Add New Comment", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
      var text = textField.text
      if text == " " {
        text = nil
      }
      self.note.text = text
      guard let noteId = self.id else {return}
      self.presenter?.noteButtonPressed(text, noteId)
    }
    let cancellAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
      return
    }
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
    }
    alert.addAction(cancellAction)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  func likeButtonSettings() {
    if favorite! {
      likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    } else {
      likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
  }
  
}

// MARK: - NotePresenterToViewProtocol Methods
extension NoteViewController: NotePresenterToViewProtocol {
  func showDetail(place: DetailUIModel) {
    dataToUI = place
    guard let data = dataToUI else {return}
    
    DispatchQueue.main.async {
      self.spinner.stopAnimating()
      self.image.kf.setImage(with: data.image)
      self.label.text = data.title.capitalized
//            self.text.text = data.bodyText.withoutHtmlTags
      self.text.attributedText = data.bodyText.htmlToAttributedString
      self.text.font = self.text.font?.withSize(19)
      self.note.text = self.noteText
    }
  }
}

// MARK: - Extension String
extension String {
  var withoutHtmlTags: String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options:
      .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with:
        "", options:.regularExpression, range: nil)
  }
}
extension String {
  var htmlToAttributedString: NSAttributedString? {
    guard let data = data(using: .utf8) else { return nil }
    do {
      return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
    } catch {
      return nil
    }
  }
  var htmlToString: String {
    return htmlToAttributedString?.string ?? ""
  }
}

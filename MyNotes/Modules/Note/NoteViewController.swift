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
  
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var viewForLabel: UIView!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var text: UITextView!
  @IBOutlet weak var note: UILabel!
  @IBOutlet weak var gradient: UIView!
  @IBOutlet weak var editButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    image.layer.cornerRadius = 30
    image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    configurator.configure(with: self)
    spinner.startAnimating()
    likeButtonSettings()
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
    let alert = UIAlertController(title: "Добавить новый комментарий", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Добавить", style: .default) { (action) in
      var text = textField.text
      if text == "" {
        text = nil
      }
      self.note.text = text
      guard let noteId = self.id else {return}
      self.presenter?.noteButtonPressed(text, noteId)
    }
    let cancellAction = UIAlertAction(title: "Отмена", style: .default) { (action) in
      return
    }
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Добавьте комментарий"
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
  
  func dates () {
    guard let data = dataToUI else {
      return
    }
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
    let formatter2 = DateFormatter()
    formatter2.locale = Locale(identifier: "ru_RU")
    if data.dates.count > 0 {
    for item in 0 ... data.dates.count - 1 {
      let dateStart = data.dates[item].start
      let dateEnd = data.dates[item].end
      let start = Date(milliseconds: Int64(dateStart))
      let end = Date(milliseconds: Int64(dateEnd))
      
      if start.fullSame(date: end) {
        formatter.dateFormat = "d MMMM   HH:mm"
        let dateStr = formatter.string(from: start)
        print(dateStr)
        let label = UILabel()
        label.myLabel()
        label.text = dateStr
        self.stackView.addArrangedSubview(label)
        
      } else if start.sameDay(date: end) {
        formatter.dateFormat = "d MMMM   HH:mm"
        let dateStr2 = formatter.string(from: start)
        formatter2.dateFormat = "HH:mm"
        let dateStr3 = formatter2.string(from: end)
        let string = "\(dateStr2) - \(dateStr3)"
        let label = UILabel()
        label.myLabel()
        label.text = string
//        label.font = label.font.withSize(15)
        self.stackView.addArrangedSubview(label)
        
      } else if !start.sameDay(date: end) && start.sameTime(date: end){
        formatter.dateFormat = "d MMMM"
        let dateStr4 = formatter.string(from: start)
        formatter2.dateFormat = "d MMMM   HH:mm"
        let dateStr5 = formatter2.string(from: end)
        let string = "\(dateStr4) - \(dateStr5)"
        let label = UILabel()
        label.myLabel()
//        label.font = label.font.withSize(15)
        label.text = string
        self.stackView.addArrangedSubview(label)
        
      } else {
        formatter.dateFormat = "d MMMM"
        let dateStr4 = formatter.string(from: start)
        formatter2.dateFormat = "d MMMM"
        let dateStr5 = formatter2.string(from: end)
        let string = "\(dateStr4) - \(dateStr5)"
        let label = UILabel()
        label.myLabel()
//        label.font = label.font.withSize(15)
        label.text = string
        self.stackView.addArrangedSubview(label)
      }
  }
  
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
      self.text.text = data.bodyText.withoutHtmlTags
      self.note.text = self.noteText
      self.editButton.isHidden = false
      self.gradient.fadeView()
      self.dates()
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


extension Date {
  
  func fullSame (date: Date, calendar: Calendar = .current) -> Bool{
    let days1 = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
    let days2 = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    return days1 == days2
  }
  
  func sameDay (date: Date, calendar: Calendar = .current) -> Bool{
    let days1 = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
    let days2 = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    return days1.day == days2.day && days1.month == days2.month
  }
  
  func sameTime (date: Date, calendar: Calendar = .current) -> Bool{
    let days1 = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
    let days2 = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    return days1.hour == days2.hour
  }
}


extension UILabel {
    func myLabel() {
        textAlignment = .center
//        textColor = .white
//        backgroundColor = .lightGray
        font = UIFont.systemFont(ofSize: 15)
        numberOfLines = 0
        lineBreakMode = .byCharWrapping
        sizeToFit()
    }
}

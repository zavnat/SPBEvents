//
//  PagingViewController.swift
//  MyNotes
//
//  Created by admin on 28.07.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import UIKit

class PagingViewController: UIViewController,WormTabStripDelegate {
  
  var tabs:[UIViewController] = []
  let numberOfTabs = 2
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = true
    setUpTabs()
    setUpViewPager()
  }
  
  func setUpTabs(){
    let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
    let favoriteVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoriteController") as! FavoriteController
    tabs.append(contentsOf: [mainVC, favoriteVC])
  }
  
  func setUpViewPager(){
    let frame =  CGRect(x: 0, y: 40, width: self.view.frame.size.width, height: self.view.frame.size.height - 40)
    let viewPager:WormTabStrip = WormTabStrip(frame: frame)
    self.view.addSubview(viewPager)
    viewPager.delegate = self
    viewPager.eyStyle.wormStyel = .BUBBLE
    viewPager.eyStyle.isWormEnable = true
    viewPager.eyStyle.topScrollViewBackgroundColor = UIColor.systemBackground
    //    viewPager.eyStyle.contentScrollViewBackgroundColor = .red
    viewPager.eyStyle.spacingBetweenTabs = 15
    viewPager.eyStyle.WormColor = .systemOrange
    viewPager.eyStyle.dividerBackgroundColor = UIColor.systemBackground
    viewPager.eyStyle.tabItemSelectedColor = .white
    viewPager.eyStyle.tabItemDefaultColor = .label
    viewPager.buildUI()
  }
  
  func WTSNumberOfTabs() -> Int {
    return numberOfTabs
  }
  
  func WTSTitleForTab(index: Int) -> String {
    if index == 0 {
      return "Новое"
    }
    return "Избранное"
  }
  
  func WTSViewOfTab(index: Int) -> UIView {
    let view = tabs[index]
    return view.view
  }
  
  func WTSReachedLeftEdge(panParam: UIPanGestureRecognizer) {
  }
  
  func WTSReachedRightEdge(panParam: UIPanGestureRecognizer) {
  }
}


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
        self.view.backgroundColor = UIColor(netHex: 0x364756)
        setUpTabs()
        setUpViewPager()
    }
    
    func setUpTabs(){
      for _ in 1...numberOfTabs {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController

            tabs.append(vc)
        }
    }
    
    func setUpViewPager(){
        let frame =  CGRect(x: 0, y: 40, width: self.view.frame.size.width, height: self.view.frame.size.height - 40)
        let viewPager:WormTabStrip = WormTabStrip(frame: frame)
        self.view.addSubview(viewPager)
        viewPager.delegate = self
        viewPager.eyStyle.wormStyel = .BUBBLE
        viewPager.eyStyle.isWormEnable = true
      viewPager.eyStyle.topScrollViewBackgroundColor = .white
      viewPager.eyStyle.contentScrollViewBackgroundColor = .red
        viewPager.eyStyle.spacingBetweenTabs = 15
      viewPager.eyStyle.WormColor = .red
        viewPager.eyStyle.dividerBackgroundColor = .white
        viewPager.eyStyle.tabItemSelectedColor = .white
      viewPager.eyStyle.tabItemDefaultColor = .black
        viewPager.buildUI()
    }
    
    func WTSNumberOfTabs() -> Int {
        return numberOfTabs
    }
    
    func WTSTitleForTab(index: Int) -> String {
        if(index%4==0){
            return "really long and longer Tab \(index)"
        }
        return "Tab \(index)"
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


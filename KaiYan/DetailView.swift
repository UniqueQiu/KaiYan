//
//  DetailView.swift
//  KaiYan
//
//  Created by Chuck on 16/4/6.
//  Copyright © 2016年 Chuck. All rights reserved.
//

import UIKit
//import SDWebImage
class DetailView: UIView {

	var list: ItemList? {
		didSet {
			if let imageScrollView = imageScrollView {
				imageScrollView.list = self.list
			}
		}
	}
	var currentIndex: Int = 0 {
		didSet {
			imageScrollView?.contentOffset.x = CGFloat(currentIndex)*UIScreen.mainScreen().bounds.width
			let item = list!.itemList[currentIndex]
			contentView?.item = item
		}
	}
	
	var imageScrollView: ImageScrollView?
	var contentView: ContentView?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		let	aImageScrollView = ImageScrollView(frame: CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height/2.2))
		imageScrollView = aImageScrollView
		addSubview(aImageScrollView)
		
		let aContentView = NSBundle.mainBundle().loadNibNamed("ContentView", owner: nil, options: nil).first as? ContentView
		if let aContentView = aContentView {
			contentView = aContentView
			aContentView.frame = CGRect(x: 0, y:(UIScreen.mainScreen().bounds.height/2.2) + 64, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - (UIScreen.mainScreen().bounds.height/2.2) - 64)
			addSubview(aContentView)
			
		}
		let swipe = UISwipeGestureRecognizer { (_) in
			self.removeFromSuperview()
		}
		swipe.direction = .Up
		contentView?.addGestureRecognizer(swipe)
		
		
	}
	
	required init?(coder aDecoder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
	super.init(coder: aDecoder)
	}
	
	
	override func awakeFromNib() {
	
	}
	
	func animationShow() {
		
	}
	
}

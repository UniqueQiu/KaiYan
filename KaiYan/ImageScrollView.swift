//
//  ImageScrollView.swift
//  KaiYan
//
//  Created by Chuck on 16/4/15.
//  Copyright © 2016年 Chuck. All rights reserved.
//

import UIKit

class ImageScrollView: UIScrollView {

	var list: ItemList? {
		didSet {
			for i in 0...list!.itemList.count-1 {
				let item = list!.itemList[i]
				let aImageView = self.subviews[i] as! ContentImageView
				aImageView.picture.sd_setImageWithURL(NSURL(string: (item.data.cover?.feed)!))
			}
		}
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		for i in 0...4 {
			let aImageView = ContentImageView()
			aImageView.backgroundColor = UIColor(red:CGFloat(arc4random_uniform(UInt32(255)))/255.0, green: CGFloat(arc4random_uniform(UInt32(255)))/255.0, blue: CGFloat(arc4random_uniform(UInt32(255)))/255.0, alpha: CGFloat(arc4random_uniform(UInt32(255)))/255.0)
			aImageView.frame = CGRect(x: CGFloat(i)*UIScreen.mainScreen().bounds.width, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height/2.2)
			contentSize.width = aImageView.frame.maxX
			addSubview(aImageView)
			
		}
		
		pagingEnabled = true
		bounces = false
		showsVerticalScrollIndicator = false
		showsHorizontalScrollIndicator = false
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

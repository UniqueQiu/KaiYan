//
//  ContentImageView.swift
//  KaiYan
//
//  Created by Chuck on 16/4/15.
//  Copyright © 2016年 Chuck. All rights reserved.
//

import UIKit

class ContentImageView: UIView {

	var picture: UIImageView
	
	override init(frame: CGRect) {
		picture = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height/2.2))
		picture.contentMode = .ScaleToFill
		
		super.init(frame: frame)
		
		addSubview(picture)
		clipsToBounds = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
 
	//设置transform
	func imageOffset() {
		//获取当前picture在window中的fame
		let pictureRectToWindow = self.convertRect(self.bounds, toView: nil)
		
		//取得当前picture x方向的中心线
		let centerX = pictureRectToWindow.midX
		
		//获取当窗口中心位置
		let windowCenter = self.window?.center
		
		//当前picture相对于窗口中心 水平方向的偏移量
		let pictureOffsetX = centerX - (windowCenter?.x)!
		
		//x偏移量与窗口高度比(不懂为什么这样比)
		let offsetDig = pictureOffsetX / self.window!.size.height
		let transX = CGAffineTransformMakeTranslation(-offsetDig * UIScreen.mainScreen().bounds.width * 0.7, 0)
		self.picture.transform = transX
	}
}

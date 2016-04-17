//
//  DetailViewController.swift
//  KaiYan
//
//  Created by Chuck on 16/4/5.
//  Copyright © 2016年 Chuck. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	

	var item: Item?
	var detailView: DetailView {
		return  NSBundle.mainBundle().loadNibNamed("DetailView", owner: nil, options: nil).first as! DetailView
	}
//	override func loadView() {
//		let view1 =
//		view = view1
//	}
	override func viewDidLoad() {
		super.viewDidLoad()
		if let item = item {
//			detailView.item = item
			view.addSubview(detailView)
		}
		automaticallyAdjustsScrollViewInsets = false
		
	}
	
	@IBAction func done() {
		dismissViewControllerAnimated(true, completion: nil)
	}
	

	
	override func viewDidLayoutSubviews() {
		super.viewWillLayoutSubviews()

	}
}

//
//  ContenView.swift
//  KaiYan
//
//  Created by Chuck on 16/4/15.
//  Copyright © 2016年 Chuck. All rights reserved.
//

import UIKit

class ContentView: UIView {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var cententLabel: UILabel!
	@IBOutlet weak var coverImageView: UIImageView!
	
	var item: Item? {
		didSet {
			titleLabel.text = item!.data.title
			cententLabel.text = item!.data.descriptions
			
		}
	}
 override init(frame: CGRect) {
	super.init(frame: frame)
	
}
	
 required init?(coder aDecoder: NSCoder) {
	super.init(coder: aDecoder)
 
	}
	
	
}

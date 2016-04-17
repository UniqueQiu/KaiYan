//
//  EveryDayTableViewCell.swift
//  KaiYan
//
//  Created by Chuck on 16/4/4.
//  Copyright © 2016年 Chuck. All rights reserved.
//

import UIKit
import Nuke


class EveryDayTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subTitleLabel: UILabel!
	var item: Item? {
		didSet {
				titleLabel.text = item!.data.title
				let subTitle = subTitleTex(item!.data.category!, duration: item!.data.duration!)
				subTitleLabel.text = subTitle
			let backgroundImageView = UIImageView()
			backgroundImageView.nk_setImageWith(NSURL(string: (item!.data.cover!.feed))!)
			backgroundView = backgroundImageView
		}
	}


	func subTitleTex(str: String, duration: Int) -> String? {

		var subStr = "#" + str
		let durationStr = "\(duration / 60)" + ":" + "\(duration % 60)"
		subStr += durationStr
		return subStr
	}
	override func setHighlighted(highlighted: Bool, animated: Bool) {
		
	}
}

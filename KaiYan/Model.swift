//
//  Model.swift
//  KaiYan
//
//  Created by Chuck on 16/4/1.
//  Copyright © 2016年 Chuck. All rights reserved.
//

import UIKit

class Model: NSObject {
	var issueList: [ItemList] = [ItemList]()
	var nextPageUrl: String = ""
	var nextPublishTime: NSTimeInterval = 0
	var newestIssueType: String = ""
	
	func getItemList(index: Int) -> ItemList {
		return issueList[index]
	}
	
	
	
}

	class ItemList: NSObject {
		var type: String = ""
		var count: Int = 0
		var itemList: [Item] = [Item]()
		var headerList: [Item] = [Item]()
	}


class Item: NSObject {
	var type: String = ""
	var data: Data = Data()
}

class Data: NSObject {
	var text: String? = ""
	var image: String? = ""
	var title: String? = ""
	var descriptions: String? = ""
	var category: String? = ""
	var duration: Int? = 0
	var playInfo: [PlayInfo?] = [PlayInfo]()
	var consumption: Consumption? = Consumption()
	var cover: Cover? = Cover()
}

class PlayInfo: NSObject {
	var height: CGFloat = 0
	var width: CGFloat = 0
	var name: String = ""
	var type: String = ""
	var url: String = ""
	
}

class Consumption: NSObject {
	var collectionCount: Int = 0
	var shareCount: Int = 0
	var playCount: Int = 0
	var replyCount: Int = 0
	
}

class Cover: NSObject {
	var feed: String = ""
	var blurred: String = ""
}

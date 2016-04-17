//
//  ViewController.swift
//  KaiYan
//
//  Created by Chuck on 16/3/24.
//  Copyright © 2016年 Chuck. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MJExtension
import MediaPlayer


class EveryDayTableView: UIViewController {
	var model = Model()
	var urlString: String {
		return "http://baobab.wandoujia.com/api/v2/feed?date=\(timeStamp())&num=7"
	}
	let cellIdentifier = "cell"
	var detailView: DetailView?
	var currentIndexPath: NSIndexPath?
	@IBOutlet weak var tableView: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()

		loadData()
		
		tableView.rowHeight = 200
		automaticallyAdjustsScrollViewInsets  = false
		
	}
	
	


}
//MARK: 数据源 与 代理
extension EveryDayTableView: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
	return	model.issueList.count
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let itemList = model.getItemList(section)
		return itemList.itemList.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EveryDayTableViewCell
		let itemList = model.getItemList(indexPath.section)
		let item = itemList.itemList[indexPath.row]
		if item.type == "video" {
			cell.item = item
		} else {
		let	item = itemList.itemList[indexPath.row+1]
			cell.item = item
		}
		return cell
	}
	
	//代理
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		currentIndexPath = indexPath
		let itemList = model.getItemList(indexPath.section)
		passDataTodetailView(itemList, indexPath: indexPath)
	}
	
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		
		if scrollView.isEqual(detailView?.imageScrollView.self) {
		
			//当imageScrollView滚动的时候, 可以刷新cententView
			let index = Int(floor(((detailView?.imageScrollView?.contentOffset.x)! - scrollView.frame.size.width / 2) / scrollView.frame.size.width)+1)
			detailView?.currentIndex = index
//			print(index)
			//当imageScrollView滚动的时候, 将tableView对应的cell也滚劝到屏幕中心
			currentIndexPath = NSIndexPath(forRow: index, inSection: currentIndexPath!.section)
			print(currentIndexPath)
			tableView.scrollToRowAtIndexPath(currentIndexPath!, atScrollPosition: .Middle, animated: true)
		}
	}

	func scrollViewDidScroll(scrollView: UIScrollView) {
		if scrollView.isEqual(detailView?.imageScrollView.self) {
			for aImageView in (scrollView as! ImageScrollView).subviews  {
					(aImageView as! ContentImageView).imageOffset()
			}
		}
	}
	
}

//MARK: --网络请求
extension EveryDayTableView {
	func loadData() {
		Alamofire.request(.GET, urlString, parameters: nil).responseJSON { response in
			if let JSON = response.result.value{
				self.model = self.parseJsonData(JSON)
				self.tableView.reloadData()
			}
		}
	}
	
	func parseJsonData(JSON: AnyObject) -> Model {
		let model = Model()
		model.nextPageUrl = JSON["nextPageUrl"] as! String
		model.newestIssueType = JSON["newestIssueType"] as! String
		model.nextPublishTime = JSON["nextPublishTime"] as! NSTimeInterval
		
		let issueList = JSON["issueList"]! as! [AnyObject]
		
		for itemList in issueList {
			let list = ItemList()
			list.type = itemList["type"] as! String
			list.count = itemList["count"] as! Int
			
			let items = itemList["itemList"] as! [[String: AnyObject]]
			for item in items {
				let aItem = Item()
				aItem.type = item["type"] as! String
				
				let data = item["data"] as! [String: AnyObject]
				aItem.data.text = data["text"]
					as? String
				aItem.data.image = data["Image"] as? String
				aItem.data.title = data["title"] as? String
				aItem.data.descriptions = data["description"] as? String
				aItem.data.category = data["category"] as? String
				aItem.data.duration = data["duration"] as? Int
				
				let playInfos = data["playInfo"] as? [[String: AnyObject]]
				
				if let playInfos = playInfos {
					for playInfo in playInfos {
						let aPlayInfo = PlayInfo()
						aPlayInfo.height = playInfo["height"] as! CGFloat
						aPlayInfo.width = playInfo["width"] as! CGFloat
						aPlayInfo.name = playInfo["name"] as! String
						aPlayInfo.type = playInfo["type"] as! String
						aPlayInfo.url = playInfo["url"] as! String
						aItem.data.playInfo.append(aPlayInfo)
					}
				}
				
				let consumption = data["consumption"] as? [String: AnyObject]
				if let consumption = consumption {
					let aConsumption = Consumption()
					aConsumption.collectionCount = consumption["collectionCount"] as! Int
					aConsumption.shareCount = consumption["shareCount"] as! Int
					aConsumption.playCount = consumption["playCount"] as! Int
					aConsumption.replyCount = consumption["replyCount"] as! Int
					aItem.data.consumption = aConsumption
					
					
				}
				let cover = data["cover"] as? [String: AnyObject]
				if let cover = cover {
					let aCover = Cover()
					aCover.feed = cover["feed"] as! String
					aCover.blurred = cover["blurred"] as! String
					aItem.data.cover = aCover
				}
				
				if aItem.type == "video" {
					list.itemList.append(aItem)
				} else {
					list.headerList.append(aItem)
				}
			}
			
			
			model.issueList.append(list)
		}
		return model
	}
	
	
	func AnimationShow() {
		
	}
	
	
	func timeStamp() -> String {
		let seconds = NSDate().timeIntervalSince1970
		return "\(Int(seconds * 1000))"
	}
	

}

//MARK: Private mothed
extension EveryDayTableView {
	private func passDataTodetailView(list: ItemList, indexPath: NSIndexPath) {
		
		let aView = creatDetailView()
		aView.list = list
		aView.currentIndex = indexPath.row
		aView.imageScrollView!.delegate = self
		view.addSubview(aView)
	}
	private func creatDetailView() -> DetailView {
		
		let detailView = DetailView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
		
		//添加一个播放按钮
		let playButton = UIButton(type: .Custom)
		playButton.setImage(UIImage(named: "Action_play"), forState: .Normal)
		playButton.setImage(UIImage(named: "Action_play_click"), forState: .Selected)
		playButton.sizeToFit()
		playButton.center = detailView.imageScrollView!.center
		detailView.addSubview(playButton)
		playButton.addTarget(self, action: #selector(playButtonDidTaped), forControlEvents: .TouchUpInside)

//		//手势
//		let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
//		detailView.addGestureRecognizer(tap)
		view.addSubview(detailView)
		
		self.detailView = detailView
		return detailView
	}
	
	func tap(gestureRecognizer: UITapGestureRecognizer) {
		
		if let detailView = self.detailView {
			detailView.removeFromSuperview()
		}
		detailView = nil
		tableView.reloadData()
		
		
	}
	
	func playButtonDidTaped()  {
		let url = NSURL(string: detailView!.list!.itemList[detailView!.currentIndex].data.playInfo[0]!.url)
		let playVC = MPMoviePlayerViewController(contentURL: url)
		
		presentMoviePlayerViewControllerAnimated(playVC)
	}

}

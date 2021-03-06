//
//  GalleryViewController.swift
//  AlmostGram
//
//  Created by Roman Salazar Lopez on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

protocol GalleryViewControllerDelegate {
	func galleryViewControllerDidFinish(image: UIImage) -> ()
}

protocol CollectionViewControllerDelegate {
	func collectionViewSelectedStatus(status: Status)
}

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
	var delegate: GalleryViewControllerDelegate?
	
	@IBOutlet weak var colletionView: UICollectionView!
	
	let myCollectionViewLayout = CustomeFlowLayout()
	
	var status = [Status]() {
		didSet {
			self.colletionView.reloadData()
		}
	}
	
	var posts = [PFObject]() {
		didSet {
			self.colletionView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.colletionView.dataSource = self
		self.colletionView.delegate = self
		self.colletionView.collectionViewLayout = FlexibleFlowLayout(columns: 3.0)
		
		let gesturePinchRecognizer = UIPinchGestureRecognizer(target: self , action: Selector("scaleCollectionWhenPinched:"))
		colletionView.addGestureRecognizer(gesturePinchRecognizer)
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(false)
		
		let query = PFQuery(className: "Status")
		
		query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
			if let objects = objects {
				self.posts = objects
			}
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.posts.count
	}
	
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.identifier(), forIndexPath: indexPath) as! ImageCollectionViewCell
		let post = self.posts[indexPath.row]
		
		if let imageFile = post["image"] as? PFFile {
			imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
				if let data = data {
					let image = UIImage(data: data)
					cell.imageView.image = image
				}
			})
		}
		
		return cell
	}
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		let cell = colletionView.cellForItemAtIndexPath(indexPath) as! ImageCollectionViewCell
		
		let image = cell.imageView.image
		
		delegate?.galleryViewControllerDidFinish(image!)
		
		self.tabBarController?.selectedIndex = 0
	}
	

	
}

//
//  GalleryViewController.swift
//  AlmostGram
//
//  Created by Roman Salazar Lopez on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	@IBOutlet weak var colletionView: UICollectionView!
	
	var posts = [PFObject]() {
		didSet {
			self.colletionView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
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
}

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

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
	var delegate: GalleryViewControllerDelegate?
	
	// Watch out for the misspelled collection view!
	@IBOutlet weak var colletionView: UICollectionView!
	
	let myCollectionViewLayout = CustomeFlowLayout()
	
	var posts = [PFObject]() {
		didSet {
			self.colletionView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
//		self.setupGestureRecognizers()
		self.colletionView.dataSource = self
		self.colletionView.delegate = self
		self.colletionView.collectionViewLayout = myCollectionViewLayout
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
	
	 // Gesture Function
	
//	func setupGestureRecognizers() {
//	let tapGestureReconizer = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
//		tapGestureReconizer.numberOfTapsRequired = 1
//		tapGestureReconizer.numberOfTapsRequired = 1
//		
//		self.colletionView.addGestureRecognizer(tapGestureReconizer)
//	}
//	
//	func handleTapGesture(){
//		
//	}
	
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

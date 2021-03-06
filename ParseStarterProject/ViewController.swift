/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
yolo slugs
*/

import UIKit
import Parse

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GalleryViewControllerDelegate, UITabBarControllerDelegate, UICollectionViewDelegate , UICollectionViewDataSource {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var filteredThumbnail: UICollectionView!
	var filteredImages = [UIImage]() {
		didSet{
			self.filteredThumbnail.reloadData()
		}
	}
	let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.imagePicker.delegate = self
		self.filteredThumbnail.delegate = self
		
		let collectionViewBounds = CGRectGetWidth(UIScreen.mainScreen().bounds)
		let collectionViewHeight = CGRectGetHeight(self.filteredThumbnail.frame)

		(collectionViewBounds, viewHeight: collectionViewHeight)

			if let tabBarController = self.tabBarController, viewControllers = tabBarController.viewControllers {
			if let galleryViewController = viewControllers[1] as? GalleryViewController {
				galleryViewController.delegate = self
			}
		}
    }

	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	@IBAction func presentImagePickerButton(sender: UIButton) {
		if UIImagePickerController.isSourceTypeAvailable(.Camera) {
			self.presentActionSheet()
		} else {
			self.presentImagePickerFor(.PhotoLibrary)
		}
	}
	
	@IBAction func uploadedImageButton(sender: UIButton) {
		
		
		if let image = self.imageView.image {
			API.uploadImage(image) { (success) -> () in
				if success {
					self.presentAlertView()
			}
		}
	}
}
	
	@IBAction func filterButton(sender: UIButton) {
		presentFilterAlert()
	}

	func presentActionSheet() {
		
		let alertController = UIAlertController(title: "", message: "Where Would you like to get your Picture From?", preferredStyle: .ActionSheet)
		
		let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action) -> Void in
		self.presentImagePickerFor(.Camera)
			
		}
		let photoLibrary = UIAlertAction(title: "Photos in Library", style: UIAlertActionStyle.Default) { (action) -> Void in
			self.presentImagePickerFor(.PhotoLibrary)
		}
		
		let cancelAction = UIAlertAction(title: "Cancel?", style: UIAlertActionStyle.Cancel, handler: nil)
		
		alertController.addAction(cameraAction)
		alertController.addAction(photoLibrary)
		alertController.addAction(cancelAction)
		self.presentViewController(alertController, animated: true, completion: nil)

		}
	
	func presentAlertView() {
		let alertController = UIAlertController(title: "", message: "Image Uploaded", preferredStyle: .Alert)
		let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
		alertController.addAction(okAction)
		self.presentViewController(alertController, animated: true, completion: nil)
	}
	
	func presentImagePickerFor(sourceType: UIImagePickerControllerSourceType) {
		
		let imagePickerController = UIImagePickerController()
		imagePickerController.sourceType = sourceType
		imagePickerController.delegate = self
		self.presentViewController(imagePickerController, animated: true, completion: nil)
	}

	func presentFilterAlert() {
		let alertController = UIAlertController(title: "Filter", message: "Pick your Favorite Filter", preferredStyle: .ActionSheet)
		
		let vintageFilterAction = UIAlertAction(title: "Vintage", style: .Default) { (alert) -> Void in
			FilterService.applyVintageEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
				if let filteredImage = filteredImage {
					self.imageView.image = filteredImage
				}
			})
		}
		let bwFilterAction = UIAlertAction(title: "Black & White", style: .Default) { (alert) -> Void in
			FilterService.applyBWEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
				if let filteredImage = filteredImage {
					self.imageView.image = filteredImage
				}
			})
		}
		let chromeFilterAction = UIAlertAction(title: "Chrome", style: .Default) { (alert) -> Void in
			FilterService.applyChromeEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
				if let filteredImage = filteredImage {
					self.imageView.image = filteredImage
				}
			})
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
		alertController.addAction(vintageFilterAction)
		alertController.addAction(bwFilterAction)
		alertController.addAction(chromeFilterAction)
		alertController.addAction(cancelAction)
		self.presentViewController(alertController, animated: true, completion: nil)
		
	}

	func galleryViewControllerDidFinish(image: UIImage) {
		self.imageView.image = image
		self.tabBarController?.selectedIndex = 0
	}
	
	// MARK: UIImagePickerController Delegate
	func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
		
		self.dismissViewControllerAnimated(true, completion: nil)
		let resizeImage = UIImage.resizeImage(image, size: CGSize(width: 500, height: 500))
		self.imageView.image = resizeImage
		presentFilterAlert()

	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func filtersPreviewViewControllerDidFinish(image: UIImage) {
		self.imageView.image = image
		self.dismissViewControllerAnimated(true, completion: nil)
		
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return filteredImages.count
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(FilterPreviewCell.identifier(), forIndexPath: indexPath) as! FilterPreviewCell
		let image = self.filteredImages[indexPath.row]
		cell.image = image
		
		return cell
	}
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		let filteredImage = self.filteredImages[indexPath.row]
		self.imageView.image = filteredImage
	}
	
	func collectionViewSelectedStatus(status: Status) {
		self.dismissViewControllerAnimated(true, completion: nil)
		self.imageView.image = status.image
		tabBarController!.selectedViewController = tabBarController!.viewControllers![0]
		presentFilterAlert()
	}
	
	

}













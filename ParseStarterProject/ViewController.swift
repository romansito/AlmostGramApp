/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var imageView: UIImageView!
	
//	let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
			
//			self.imagePicker.delegate = self
			
			let testObject = PFObject(className: "TestObject")
			testObject["foo"] = "bar"
			testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
				print("Object has been saved.")
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
//			self.presentViewController(self.imagePicker, animated: true, completion: nil)
		}
	}


	
	@IBAction func uploadedImageButton(sender: UIButton) {
		
//	sender.enabled = false
		
		if let image = self.imageView.image {
			API.uploadImage(image) { (success) -> () in
				if success {
//					sender.enabled = true
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
		// Add Alert Controller
		let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
		
		alertController.addAction(vintageFilterAction)
		alertController.addAction(bwFilterAction)
		alertController.addAction(chromeFilterAction)
		alertController.addAction(cancelAction)
		
		
		self.presentViewController(alertController, animated: true, completion: nil)
		
	}
	
	
	// MARK: UIImagePickerController Delegate
	// Here you'll find the two protocol functions to the UIImagePicker Controller

	func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
		
		print(image)
		
			self.imageView.image = image
			self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
}













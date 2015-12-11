//
//  FlexibleFlowLayout.swift
//  AlmostGram
//
//  Created by Roman Salazar Lopez on 11/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class FlexibleFlowLayout: UICollectionViewFlowLayout {
	
	init(columns: CGFloat) {
		super.init()
		
		let frame = UIScreen.mainScreen().bounds
		let width = CGRectGetWidth(frame)
		let cellWidth = (width / columns) - 2.0
		let size = CGSizeMake( cellWidth, cellWidth)
		
		self.itemSize = size
		self.minimumInteritemSpacing = 2.0
		self.minimumLineSpacing = 2.0
		
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	func filteredThumbnails() {
	
		func thumbnailsFlowLayout(viewWidth: CGFloat, viewHeight: CGFloat) {
			
			//self.minimumInteritemSpacing = 1.0
			self.minimumLineSpacing = 1.0
			//let numberColumns: CGFloat = 2.0
			let cellWidth = viewHeight - self.minimumLineSpacing
			self.itemSize = CGSize(width: cellWidth, height: cellWidth)
			self.scrollDirection = UICollectionViewScrollDirection.Horizontal
			print("Cell Width \(cellWidth)")
		}
	}


}

//
//  CustomeFlowLayout.swift
//  AlmostGram
//
//  Created by Roman Salazar Lopez on 11/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class CustomeFlowLayout: UICollectionViewFlowLayout {

	override init() {
		super.init()
		self.setup()
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

	
	func setup() {
		self.itemSize = CGSizeMake(159.0, 159.0)
			self.minimumLineSpacing = 2.0
			self.minimumInteritemSpacing = 2.0
		
	}


}

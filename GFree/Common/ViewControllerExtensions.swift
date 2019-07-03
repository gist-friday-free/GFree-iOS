//
//  ViewControllerExtensions.swift
//  GFree
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 MJ Studio. All rights reserved.
//

import UIKit

//MARK: Add/Remove ChildViewController
extension UIViewController{
	func addBottomSheet(asChildViewController viewController : UIViewController){
	
		self.addChild(viewController)
		self.view.addSubview(viewController.view)
		
		print(screenWidth)
		viewController.view.frame = CGRect(x: 0, y: screenHeight/2, width: screenWidth, height: screenHeight/2)
		viewController.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
		viewController.didMove(toParent: self)
		
	}
	func add(asChildViewController viewController : UIViewController){
		self.addChild(viewController)
		self.view.addSubview(viewController.view)
		
		viewController.view.frame = self.view.bounds
		viewController.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
		viewController.didMove(toParent: self)
	}
	func remove(asChildViewController viewController : UIViewController){
		viewController.willMove(toParent: nil)
		viewController.view.removeFromSuperview()
		viewController.removeFromParent()
	}
}

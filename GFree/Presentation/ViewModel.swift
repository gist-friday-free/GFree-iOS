//
//  ViewModel.swift
//  GFree
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 MJ Studio. All rights reserved.
//

import Foundation

@objc protocol ViewModel {
	@objc optional func viewWillAppear()
	@objc optional func viewWillDisappear()
}

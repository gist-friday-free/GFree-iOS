//
//  ColorRes.swift
//  GFree
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 MJ Studio. All rights reserved.
//

import UIKit

enum ColorRes : String{
	case colorPrimary = "colorPrimary"
}
extension ColorRes{
	var color : UIColor{
		return UIColor(named: self.rawValue)!
	}

}




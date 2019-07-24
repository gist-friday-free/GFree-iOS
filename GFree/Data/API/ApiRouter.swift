//
//  ApiRouter.swift
//  GFree
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 MJ Studio. All rights reserved.
//

import Foundation

enum ApiRouter{
	case login
	
	
	var url : String{
		switch self{
		case .login:
			return "/user"
		}
	}
}


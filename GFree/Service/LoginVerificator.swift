
//
//  LoginVerificator.swift
//  GFree
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 MJ Studio. All rights reserved.
//

import Foundation

class LoginVerificator{
	class func isEmailValid(_ email : String) -> Bool{
		
		guard let _ = email.range(of: "@gist.ac.kr") else { return false}
		
		
		return true
	}
	
	class func isPasswordValid(_ password : String) -> Bool{
		
		guard password.count >= 6 else {return false}
		
		
		return true
	}
}

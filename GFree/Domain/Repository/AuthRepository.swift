//
//  AuthRepository.swift
//  GFree
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 MJ Studio. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

protocol AuthRepository{
	
	func checkAlreadyLogin() -> Bool
	func signIn(email : String, password : String) -> Single<User>
}

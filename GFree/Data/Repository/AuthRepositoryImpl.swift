//
//  AuthRepositoryImpl.swift
//  GFree
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 MJ Studio. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

class AuthRepositoryImpl : AuthRepository{
	
	public static let shared = AuthRepositoryImpl()
	private init(){}
	
	func signIn(email: String, password: String) -> Single<User> {
		return Single<User>.create{emitter in
			Auth.auth().signIn(withEmail: email, password: password) { result, error in
				
				if let result = result{
					let user = result.user
					emitter(.success(user))
				}else{
					emitter(.error(error!))
				}
			}
			return Disposables.create()
		}
	}
	
	func checkAlreadyLogin() -> Bool {
		return Auth.auth().currentUser != nil
	}
	

}

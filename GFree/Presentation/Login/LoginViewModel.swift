//
//  LoginViewModel.swift
//  GFree
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 MJ Studio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase


class LoginViewModel : ViewModel{
	
	
	let disposeBag = DisposeBag()
	
	let emailText : BehaviorRelay<String?> = BehaviorRelay(value: "")
	let passwordText : BehaviorRelay<String?> = BehaviorRelay(value: "")
	
	
	required init() {
	}
	
	func viewWillAppear() {
		checkAlreadyLogin()
	}
	func viewWillDisappear() {
		
	}
	
	
}


extension LoginViewModel{
	func signIn(){
		Repository.auth.signIn(email: emailText.value ?? "", password: passwordText.value ?? "")
			.addObserver()
			.subscribe(onSuccess: { user in
				print(user)
			}, onError: {
				print($0)
			}).disposed(by: disposeBag)
		
	}
	
	private func checkAlreadyLogin(){
		if Repository.auth.checkAlreadyLogin(){
			
		}else{
			print("noUser")
		}
	}
}

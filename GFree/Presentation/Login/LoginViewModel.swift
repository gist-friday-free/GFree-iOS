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


class LoginViewModel{
	
	let disposeBag = DisposeBag()
	
	let emailText : BehaviorRelay<String?> = BehaviorRelay(value: "")
	let passwordText : BehaviorRelay<String?> = BehaviorRelay(value: "")
	
	
	required init() {
		
	}
	
	
}

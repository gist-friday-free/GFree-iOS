//
//  SignUpViewController.swift
//  GFree
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 MJ Studio. All rights reserved.
//

import UIKit
import Hero
import FittedSheets
import TextFieldEffects
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
	@IBOutlet var mSignUpButton: UIButton!
	@IBOutlet var mCancelButton: UIButton!
	@IBOutlet var mEmailTextField : HoshiTextField!
	@IBOutlet var mPasswordTextField : HoshiTextField!
	
	private let disposeBag = DisposeBag()
}

extension SignUpViewController{
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.hero.isEnabled = true
		
		setupBinding()
	}
}

extension SignUpViewController{
	private func setupBinding(){
		mCancelButton.rx.controlEvent(.touchUpInside)
			.throttle(0.3, scheduler: MainScheduler.instance)
			.subscribe(onNext : {
				self.sheetViewController?.closeSheet()
			}).disposed(by: disposeBag)
	}
}

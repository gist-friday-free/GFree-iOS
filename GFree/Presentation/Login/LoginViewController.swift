//
//  ViewController.swift
//  GFree
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 MJ Studio. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftyButton
import RxSwift
import RxCocoa
import MaterialComponents.MaterialBottomSheet

class LoginViewController: UIViewController {
	@IBOutlet var mEmailTextField: HoshiTextField!
	@IBOutlet var mPasswordTextField: HoshiTextField!
	@IBOutlet var mSignInButton: SwiftyCustomContentButton!
	@IBOutlet var mSignUpButton: SwiftyCustomContentButton!
	
	private let mDisposeBag = DisposeBag()
	private let mViewModel = LoginViewModel()
}

//MARK: Lifecycle
extension LoginViewController{
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		
		setupView()
		setupBinding()
	}
}
//MARK: Setup
extension LoginViewController{
	private func setupView(){
		
	}
	private func setupBinding(){
		(mEmailTextField.rx.text <-> mViewModel.emailText).disposed(by: mDisposeBag)
		(mPasswordTextField.rx.text <-> mViewModel.passwordText).disposed(by: mDisposeBag)
		
		mEmailTextField.rx.text
			.debounce(0.3, scheduler: MainScheduler.instance)
			.subscribe(onNext :{[unowned self] str in
				guard let email = str else {return}
				
				let isEmailValid = LoginVerificator.isEmailValid(email)
				
				if email.count>0 && !isEmailValid{
					self.mEmailTextField.placeholderColor = UIColor.red
				}
				else if isEmailValid{
					self.mEmailTextField.placeholderColor = ColorRes.colorPrimary.color
				}
				else{
					if self.mEmailTextField.placeholderColor != UIColor.lightGray{
					self.mEmailTextField.placeholderColor = UIColor.lightGray
					}
				}
				
			}).disposed(by: mDisposeBag)
		
		mPasswordTextField.rx.text
			.debounce(0.3, scheduler: MainScheduler.instance)
			.subscribe(onNext: {[unowned self]  str in
				guard let password = str else {return}
				
				let isPasswordValid = LoginVerificator.isPasswordValid(password)
				
				if password.count>0 && !isPasswordValid{
					self.mPasswordTextField.placeholderColor = UIColor.red
				}
				else if isPasswordValid{
					self.mPasswordTextField.placeholderColor = ColorRes.colorPrimary.color
				}
				else{
					if self.mPasswordTextField.placeholderColor != UIColor.lightGray{
					self.mPasswordTextField.placeholderColor = UIColor.lightGray
					}
				}
			}).disposed(by: mDisposeBag)
		
		mSignInButton.rx.controlEvent(.touchUpInside)
			.throttle(0.5, scheduler: MainScheduler.instance)
			.subscribe(onNext:{
				
			}).disposed(by: mDisposeBag)
		
		mSignUpButton.rx.controlEvent(.touchUpInside)
			.throttle(0.5, scheduler: MainScheduler.instance)
			.subscribe(onNext:{[unowned self] in
				self.presentSignUpBottomSheet()
			}).disposed(by: mDisposeBag)
	}
}
//MARK: Action
extension LoginViewController{
	@IBAction func tapBackground(_ sender: UITapGestureRecognizer) {
		if mEmailTextField.isFirstResponder{
			mEmailTextField.resignFirstResponder()
		}
		if mPasswordTextField.isFirstResponder{
			mPasswordTextField.resignFirstResponder()
		}
	}
}
//MARK: SignUp
extension LoginViewController{
	private func presentSignUpBottomSheet(){
		// View controller the bottom sheet will hold
		let viewController = SignUpViewController()
		// Initialize the bottom sheet with the view controller just created
		let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: viewController)
		viewController.view.backgroundColor = ColorRes.colorPrimary.color
		// Present the bottom sheet
		present(bottomSheet, animated: true, completion: nil)
	}
}


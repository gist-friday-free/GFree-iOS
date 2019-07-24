//
//  ViewController.swift
//  GFree
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 MJ Studio. All rights reserved.
//

import UIKit
import TextFieldEffects
import RxSwift
import RxCocoa
import FittedSheets

class LoginViewController: UIViewController {
	@IBOutlet var mEmailTextField: HoshiTextField!
	@IBOutlet var mPasswordTextField: HoshiTextField!
	@IBOutlet var mSignInButton: UIButton!
	@IBOutlet var mSignUpButton: UIButton!
	
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
	override func viewWillAppear(_ animated: Bool) {
		mViewModel.viewWillAppear()
	}
	override func viewWillDisappear(_ animated: Bool) {
		mViewModel.viewWillDisappear()
	}
}
//MARK: Setup
extension LoginViewController{
	private func setupView(){
		self.mSignUpButton.hero.id = "signupbutton"
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
			.subscribe(onNext:{[unowned self] in
				self.mViewModel.signIn()
			}).disposed(by: mDisposeBag)
		
		mSignUpButton.rx.controlEvent(.touchUpInside)
			.throttle(0.5, scheduler: MainScheduler.instance)
			.subscribe(onNext:{[unowned self] in
				self.presentSignUpBottomSheet()
			}).disposed(by: mDisposeBag)
		
		let alert = UIAlertController(title: "1", message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>
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
		
		let bottomSheet = SheetViewController(controller: viewController, sizes: [SheetSize.fixed(screenHeight * 0.8)])
		
		bottomSheet.hero.isEnabled = true
		bottomSheet.topCornersRadius = 15
		bottomSheet.extendBackgroundBehindHandle = true
		
		
		
		
		self.present(bottomSheet, animated: false, completion: nil)
	}
}


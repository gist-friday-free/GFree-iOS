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

class LoginViewController: UIViewController {
	@IBOutlet var mEmailTextField: HoshiTextField!
	@IBOutlet var mPasswordTextField: HoshiTextField!
	@IBOutlet var mSignInButton: SwiftyCustomContentButton!
	


	
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


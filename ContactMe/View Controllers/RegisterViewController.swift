//
//  RegisterViewController.swift
//  ContactMe
//
//  Created by Javier Portaluppi on 08/11/2019.
//  Copyright © 2019 IPL-Master. All rights reserved.
//

import UIKit
import EGFormValidator
import KeychainAccess


class RegisterViewController: ValidatorViewController {
    
    //    MARK: Outlets
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordErrorLabel: UILabel!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.hideKeyboardWhenTappedAround()

        
        self.addValidatorEmail(toControl: self.emailTextField,
                               errorPlaceholder: self.emailErrorLabel,
                               errorMessage: "Email is invalid")
        self.addValidatorMandatory(toControl: self.emailTextField,
                                   errorPlaceholder: self.emailErrorLabel,
                                   errorMessage: "This field is required")
        
        
        self.addValidatorMinLength(toControl: self.passwordTextField,                 errorPlaceholder: self.passwordErrorLabel,
                                   errorMessage: "Enter at least %d characters", minLength: 8)
        self.addValidatorMandatory(toControl: self.passwordTextField,                   errorPlaceholder: self.passwordErrorLabel,
                                   errorMessage: "This field is required")
        
        
        self.addValidatorMinLength(toControl: self.repeatPasswordTextField,                 errorPlaceholder: self.repeatPasswordErrorLabel,
                                   errorMessage: "Enter at least %d characters", minLength: 8)
        self.addValidatorMandatory(toControl: self.repeatPasswordTextField,                   errorPlaceholder: self.repeatPasswordErrorLabel,
                                   errorMessage: "This field is required")
        
        self.addValidatorEqualTo(toControl: self.repeatPasswordTextField, errorPlaceholder: self.repeatPasswordErrorLabel, errorMessage: "Passwords don't match", compareWithControl: self.passwordTextField)
        
        
    }
    
    //    MARK:Actions
    @IBAction func signUpButton(_ sender: Any) {
        print("Sign Up pressed")
        
        if self.validate(){
            
            let entity = User()
            entity.username = self.emailTextField.text
            entity.password = self.passwordTextField.text
            
            if UserService.getRegisterUserByUserName(username: entity.username!) == nil{
                
                let profile = Profile()
                
                //set email as username default
                profile.email = entity.username
                
                let profileId = try! ProfileDataHelper.insert(item: profile)
                
                entity.profileId = profileId
                
                let json = UserService.createUser(user: entity)
                print(json)
                
                // create the alert
                let alert = UIAlertController(title: "User created!", message: "Your account is ready to login", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) -> Void in
                    self.navigateToLogin()
                }))

                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                showUserAlreadyExistAlert()
            }
            
        }else{
            showInvalidDataAlert()
        }
    }
    
    @IBAction func emailEditingChanged(_ sender: Any) {
        _ = self.validate()
    }
    @IBAction func passwordEditingChanged(_ sender: Any) {
        _ = self.validate()
    }
    @IBAction func repeatPasswordEditingChanged(_ sender: Any) {
        _ = self.validate()
    }
    
    func showInvalidDataAlert() {
        let alert = UIAlertController(title: "Alert", message: "Incorrect data, check the form data.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showUserAlreadyExistAlert() {
        let alert = UIAlertController(title: "Alert", message: "Incorrect data, username already exist!.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    func navigateToLogin(){
        let storyboard = UIStoryboard(name: Constants.Identifiers.STORYBOARD, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Constants.Identifiers.LOGIN)
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape{
            self.logoImage.isHidden = true
        }else{
            self.logoImage.isHidden = false
        }
    }
}

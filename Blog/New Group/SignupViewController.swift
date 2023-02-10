//
//  SignupViewController.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//


import StoreKit
import UIKit
import RevenueCat
import Foundation


  
class SignupViewController: UIViewController {
    private let headerview = HeaderView()
    private let namefield: UITextField = {
         let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
         field.keyboardType = .namePhonePad
         field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
         field.leftViewMode = .always
         field.placeholder = "user name"
         field.backgroundColor = .systemBackground
         field.layer.cornerRadius = 8
         field.layer.masksToBounds = true
       return field
     }()
       private let emailfield: UITextField = {
            let field = UITextField()
           field.autocapitalizationType = .none
           field.autocorrectionType = .no
            field.keyboardType = .emailAddress
            field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
            field.leftViewMode = .always
            field.placeholder = "Email Address"
            field.backgroundColor = .systemBackground
            field.layer.cornerRadius = 8
            field.layer.masksToBounds = true
          return field
        }()
        private let passwordfield: UITextField = {
            let field = UITextField()
            field.autocapitalizationType = .none
            field.autocorrectionType = .no
            field.leftViewMode = .always
            field.isSecureTextEntry = true
            field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
            field.placeholder = "password"
            field.backgroundColor = .systemBackground
            field.layer.cornerRadius = 8
            field.layer.masksToBounds = true
          return field
        }()
        
        private let siginupbutton: UIButton  = {
            let button = UIButton()
            button.backgroundColor = .systemGreen
            button.setTitle("Create Account", for: .normal)
            button.setTitleColor(.white, for: .normal)
            
          return button
        }()
        
  
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .brown
           title = "Create Account"
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                if !iappmanager.Shared.ispremium() {
                    let vc = PaywallViewController()
                    let navc = UINavigationController(rootViewController: vc)
                    navc.modalPresentationStyle = .overFullScreen
                    self.present(navc, animated: true,completion: nil)
                }
            }
            view.addSubview(headerview)
            view.addSubview(emailfield)
            view.addSubview(passwordfield)
            view.addSubview(namefield)
            view.addSubview(siginupbutton)
            siginupbutton.addTarget(self, action: #selector(didtapsignup), for: .touchUpInside)
         
        }
        

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            headerview.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height/4)
            emailfield.frame = CGRect(x: 25, y: Int(headerview.frame.maxY) + 30, width: Int(view.frame.width) - 40, height: 30)
            passwordfield.frame = CGRect(x: 25, y: Int(emailfield.frame.maxY) + 10, width: Int(view.frame.width) - 40, height: 30)
            namefield.frame = CGRect(x: 25, y: Int(passwordfield.frame.maxY) + 10, width: Int(view.frame.width) - 40, height: 30)
          siginupbutton.frame = CGRect(x: 25, y: Int(namefield.frame.maxY) + 10, width: Int(view.frame.width) - 40, height: 30)
         
            

            
        }
        
        
        
        @objc func didtapsignup() {
            guard let email = emailfield.text, !email.isEmpty,
                  let password = passwordfield.text, !password.isEmpty,
                  let name = namefield.text, !name.isEmpty else {return}
            
            
            
            // create user
            AuthManager.shared.signup(email: email, password: password) { [weak self ]sucess in
                if sucess {
                    let newuser = User(name: name, email: email, profile_url: nil)
                    databasemanager.shared.insertuser(for: newuser) { inserted in
                        guard inserted  else {return}
                        
                        DispatchQueue.main.async {
                            UserDefaults.standard.set(email, forKey: "email")
                            UserDefaults.standard.set(name, forKey: "name")
                            let vc = TabbarViewController()
                            vc.modalPresentationStyle = .fullScreen
                            self?.present(vc, animated: true)
                        }
                    }
                    
                    
                }else{
                    print("failed to create account ")
                }
            }
            
            
            
            //update database
            
            
        }
        
    }


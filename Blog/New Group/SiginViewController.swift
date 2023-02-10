//
//  SiginViewController.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//
import StoreKit
import UIKit
import RevenueCat
import Foundation



class SiginViewController: UIViewController {
    private let headerview = HeaderView()
    
    
    
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
    
    private let siginbutton: UIButton  = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("Sign in ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
      return button
    }()
    
    private let CreateAccountbutton :UIButton  = {
        let button = UIButton()
      
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
      return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
       title = "Signin"
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            if !iappmanager.Shared.ispremium() {
                let vc = PaywallViewController()
                let navc = UINavigationController(rootViewController: vc)
                navc.modalPresentationStyle = .fullScreen
                self.present(navc, animated: true,completion: nil)
            }
        }
        view.addSubview(headerview)
        view.addSubview(emailfield)
        view.addSubview(passwordfield)
        view.addSubview(CreateAccountbutton)
        view.addSubview(siginbutton)
        siginbutton.addTarget(self, action: #selector(didtapignin), for: .touchUpInside)
        CreateAccountbutton.addTarget(self, action: #selector(didtapCreateAccount), for: .touchUpInside)
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerview.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height/4)
        emailfield.frame = CGRect(x: 25, y: Int(headerview.frame.maxY) + 30, width: Int(view.frame.width) - 40, height: 30)
        passwordfield.frame = CGRect(x: 25, y: Int(emailfield.frame.maxY) + 10, width: Int(view.frame.width) - 40, height: 30)
        siginbutton.frame = CGRect(x: 25, y: Int(passwordfield.frame.maxY) + 10, width: Int(view.frame.width) - 40, height: 30)
        CreateAccountbutton.frame = CGRect(x: 25, y: Int(siginbutton.frame.maxY) + 10, width: Int(view.frame.width) - 40, height: 30)


        

        
    }
    
    
    
    @objc func didtapignin() {
        
        guard let email = emailfield.text, !email.isEmpty,
              let password = passwordfield.text, !password.isEmpty
              else {return}
        
        
        
        // create user
        AuthManager.shared.signin(email: email, password: password) { [weak self ]sucess in
            if sucess {
               
             
                guard sucess else {return}
                    
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(email, forKey: "email")
                        let vc = TabbarViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true)
                    }
                
            }else{
                print("s ")
            }
        }
        
    }
    
    @objc func didtapCreateAccount() {
        let vc = SignupViewController()
        vc.title = "Create Account"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
}

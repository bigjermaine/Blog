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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
       title = "Signin"
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            if !iappmanager.Shared.ispremium() {
                let vc = PaywallViewController()
                let navc = UINavigationController(rootViewController: vc)
                navc.modalPresentationStyle = .overFullScreen
                self.present(navc, animated: true,completion: nil)
            }
        }
        view.addSubview(headerview)
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerview.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height/4)
    }

}

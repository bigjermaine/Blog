//
//  PaywallViewController.swift
//  Blog
//
//  Created by Apple on 01/02/2023.
//
import StoreKit
import UIKit
import RevenueCat
import Foundation


class PaywallViewController: UIViewController {
    var payview = PaydescriptiveView()
    private let headerimageview:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Crown"))
        imageView.contentMode = .scaleAspectFill
        
        imageView.tintColor = .white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
        
    }()
    
    private let buyButton:UIButton = {
        let imageView = UIButton()
        imageView.setTitle("Subcribe", for: .normal)
        imageView.backgroundColor = .systemBackground
        imageView.setTitleColor(.systemBlue, for: .normal)
        imageView.backgroundColor = .systemRed
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let buyButton2:UIButton = {
        let imageView = UIButton()
        imageView.setTitle("RestorePurchases", for: .normal)
        
        imageView.setTitleColor(.link, for: .normal)
        
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
        
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Blog Premium"
        view.backgroundColor = .white
        view.addSubview(headerimageview)
        view.addSubview(buyButton)
        view.addSubview(buyButton2)
        view.addSubview(payview)
       // configureconstraints()
        setUpCloseButton()
        setUpButtons()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buyButton.frame = CGRect(x: 25, y: Int(view.frame.size.height) - 200, width: Int(view.frame.size.width) - 50 , height: 50)
        buyButton2.frame = CGRect(x: 25, y: Int(view.frame.height) - 270, width:  Int(view.frame.width) - 50 , height: 50)
        payview.frame = CGRect(x: 25, y: Int(headerimageview.frame.height)+100, width:  Int(view.frame.width) - 50 , height: 100)
        headerimageview.frame =  CGRect(x: 25, y: Int(view.safeAreaInsets.top) + 100, width: Int(view.frame.size.width) - 50 , height: 100)
    }
    private func setUpButtons() {
        buyButton.addTarget(self, action: #selector(didTapbuy), for: .touchUpInside)
        buyButton2.addTarget(self, action: #selector(didTaprestore), for: .touchUpInside)
        
    }
    private func setUpCloseButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapclose))
    }
    
    @objc private func didTapclose() {
        //dismiss(animated: true,completion: nil)
    }
    
    @objc private func didTaprestore() {
        iappmanager.Shared.restorepurchase {[weak self] Package
            in
         
              
                
                DispatchQueue.main.async {
                    if Package {
                        self?.dismiss(animated: true, completion: nil)
                        print("sucessfully \(Package)")
                    }else {
                        let alert = UIAlertController(title: "Restoration Failed", message: "we were enable to Restore", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "cancel", style: .cancel,handler: nil))
                        self?.present(alert, animated: true)
                    }
                }
            }
        }
    
    @objc private func didTapbuy() {
        iappmanager.Shared.fetchpackage {[weak self] Package
            in
            guard let package = Package else {return}
            iappmanager.Shared.subcribe(package: package) { [weak self]  package in
                print("sucessfully \(package)")
        DispatchQueue.main.async {
                    if package {
                        self?.dismiss(animated: true, completion: nil)
                    }else {
                        let alert = UIAlertController(title: "Subcription failed", message: "we were couldnt restore", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "cancel", style: .cancel,handler: nil))
                        self?.present(alert, animated: true)
                    }
                }
            }
        }
        
    }
 }


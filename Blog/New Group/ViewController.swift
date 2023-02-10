//
//  ViewController.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//

import UIKit

class ViewController:  UIViewController { 
    private let composebutton:  UIButton = {
        
       let button = UIButton()
        button.setImage(UIImage(systemName:  "pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)),for:.normal)
        
        button.layer.borderColor  =  UIColor.systemBackground.cgColor
        button.backgroundColor = .systemBlue
        button.layer.borderWidth = 1
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        button.layer.cornerRadius = 40
        return button
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .systemBackground
        // Do any additional setup after loading the view.
        view.addSubview(composebutton)
        configureconstraints()
        composebutton.addTarget(self, action: #selector(proj), for: .touchUpInside)
    }
    
    
    
    
    @objc public  func proj() {
        let vc = CreateViewController()
        vc.title = "Create Post"
        let navc = UINavigationController(rootViewController: vc)
        present(navc, animated: true)
        
        
        
    }
    func configureconstraints() {
       
            let webconstraints = [
                composebutton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -190),
                composebutton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
                composebutton.heightAnchor.constraint(equalToConstant: 80),
                composebutton.widthAnchor.constraint(equalToConstant: 80)
            ]
           
        
        NSLayoutConstraint.activate(webconstraints)
    }
}


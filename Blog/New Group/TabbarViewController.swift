//
//  TabbarViewController.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupControllers()
    }
    

    private func setupControllers() {
        let home = ViewController()
        home.title = "Home"
        home.navigationItem.largeTitleDisplayMode = .always
        let profile = ProfileViewController()
        profile.title = "Profile"
        profile.navigationItem.largeTitleDisplayMode = .always
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: profile)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        setViewControllers([nav1,nav2], animated: true)
        
        
    }
    
    
    
    

}

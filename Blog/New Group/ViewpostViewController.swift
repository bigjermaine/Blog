//
//  ViewpostViewController.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//

import UIKit

class ViewpostViewController: UIViewController {
    private let post:Blog
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .systemRed
    }
    
    init(post:Blog){
        self.post = post
        super.init(nibName: nil, bundle: nil)
        
        
    }
    private let tableview: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

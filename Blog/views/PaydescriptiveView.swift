//
//  PaydescriptiveView.swift
//  Blog
//
//  Created by Apple on 01/02/2023.
//

import UIKit

class PaydescriptiveView: UIView {

    private let descriptiveview :UILabel = {
       let label = UILabel()
       label.textAlignment = .center
       label.font  = .systemFont(ofSize: 14, weight: .medium)
       label.numberOfLines = 0
       label.text = "join blog premium to read unlimited articles"
       return label
        
    }()
    private let descriptiveview2 :UILabel = {
       let label = UILabel()
       label.textAlignment = .center
       label.font  = .systemFont(ofSize: 14, weight: .medium)
       label.numberOfLines = 1
        label.text = "4.88/month"
       return label
        
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        clipsToBounds = true
        addSubview(descriptiveview)
        addSubview(descriptiveview2)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        descriptiveview.frame  = CGRect(x: 20, y: 0, width: Int(frame.size.width)-40, height: Int(frame.size.height)/2)
        descriptiveview2.frame  = CGRect(x: 20, y: Int(frame.size.height)/2, width: Int(frame.size.width)-40, height: Int(frame.size.height)/2)
      }
    }


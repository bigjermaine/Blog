//
//  HeaderView.swift
//  Blog
//
//  Created by Apple on 03/02/2023.
//

import UIKit

class HeaderView: UIView {

    
    private let imageview:UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "jermaine"))
        imageview.contentMode = .scaleAspectFill

        imageview.clipsToBounds = true
        return imageview
        
    }()
    private let label:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .green
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = "EXplore millions of articles "
        
       return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        clipsToBounds = true
        addSubview(label)
        addSubview(imageview)
        configureconstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageview.frame = bounds
//        let size: CGFloat = frame.size.width/4
//        imageview.frame = CGRect(x: CGFloat(Int((frame.size.width - size))/2), y: 10, width: size, height: size)
//        label.frame = CGRect(x: 20, y: imageview.frame.height + 10, width: frame.size.width - 40 , height:  frame.size.height - size - 30)
   }
    func configureconstraints() {
        let webconstraints = [
            imageview.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            imageview.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageview.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageview.heightAnchor.constraint(equalToConstant: 250)
        ]
      
        
        let dowloadbuttonConstraints = [
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.widthAnchor.constraint(equalToConstant: 8),
            label.heightAnchor.constraint(equalToConstant: 20)
        ]
           
        NSLayoutConstraint.activate(webconstraints)
        NSLayoutConstraint.activate(dowloadbuttonConstraints)
    }
}

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
        imageview.contentMode = .scaleAspectFit
        imageview.backgroundColor = .systemRed
       
        return imageview
        
    }()
    private let label:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = "EXplore millions of articles "
        
       return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        clipsToBounds = true
        addSubview(label)
        addSubview(imageview)
        
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = frame.size.width/4
        imageview.frame = CGRect(x: CGFloat(Int((frame.size.width - size))/4), y: 10, width: size, height: size)
        label.frame = CGRect(x: 20, y: imageview.frame.height + 10, width: frame.size.width - 40 , height:  frame.size.height - size - 30)
    }
}

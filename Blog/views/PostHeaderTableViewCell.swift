//
//  PostHeaderTableViewCell.swift
//  Blog
//
//  Created by Apple on 10/02/2023.
//

import UIKit
class postpreviewtableviewcellviewmodel {
    var title:String
    var imageurl:URL?
    var imagedata: Data?
    
    
    init(title: String, imageurl: URL?) {
        self.title = title
        self.imageurl = imageurl
    
    }
    

}


class PostHeaderTableViewCell: UITableViewCell {
    
    
    static let identifier = "PostHeaderTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.masksToBounds = true
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius  = 8
        imageview.translatesAutoresizingMaskIntoConstraints = true
        imageview.contentMode = .scaleAspectFill
        

    return imageview
    }()
    private let postTitlelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        postTitlelabel.sizeToFit()
      //  contentView.addSubview(postImageView)
        contentView.addSubview(postTitlelabel)
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postTitlelabel.sizeToFit()
        postImageView.frame = CGRect(x: 0, y: 0, width: 30, height:20)
        postTitlelabel.frame = CGRect(x: 15, y: 0, width:postTitlelabel.frame.size.width, height: contentView.frame.size.height)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        postTitlelabel.text =  nil
//        postImageView.image =  nil
        
    }
    
    
    func configure(with viewmodel:postpreviewtableviewcellviewmodel ){
         postTitlelabel.text =  viewmodel.title
        
        
        if let data = viewmodel.imagedata {
            
            
          postImageView.image = UIImage(data: data)
        }else if  let url = viewmodel.imageurl {
            let task = URLSession.shared.dataTask(with: url) {[weak self ] data, _, _ in
                guard let data = data else {  return}
                
                viewmodel.imagedata = data
                DispatchQueue.main.async{
                    self?.postImageView.image =  UIImage(data: data)
                }
            }
            task.resume()
        }
        
    }
    
    
}

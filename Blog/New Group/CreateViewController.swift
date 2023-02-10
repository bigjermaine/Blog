//
//  CreateViewController.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//

import UIKit

class CreateViewController: UIViewController {
    private var selectedheaderimage: UIImage?
    
    private let headeImage : UIImageView  = {
        let    headeImage = UIImageView()
        headeImage.image = UIImage(systemName:"person")
        headeImage.contentMode = .scaleAspectFill
        headeImage.isUserInteractionEnabled = true
        headeImage.backgroundColor = .tertiarySystemBackground
        headeImage.tintColor = .white
        headeImage.translatesAutoresizingMaskIntoConstraints = false
        headeImage.layer.masksToBounds = true

        
        headeImage.isUserInteractionEnabled = true
        
        return  headeImage
    }()
    private let titlefield: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .words
        field.keyboardType = .emailAddress
        field.translatesAutoresizingMaskIntoConstraints = false
        field.leftViewMode = .always
        field.placeholder = "Enter Title"
        field.backgroundColor = .tertiarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    private let textview:UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.backgroundColor = .tertiarySystemBackground
        textview.isEditable = true
        textview.font = .systemFont(ofSize: 20)
        textview.layer.masksToBounds = true
        return textview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CreateAccount"
        view.addSubview(textview)
        view.addSubview(titlefield)
        view.addSubview(headeImage)
        view.backgroundColor = .green
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.seal.fill"), style: .plain, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: self, action: #selector(post))
        // Do any additional setup after loading the view.
        configureconstraints()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didtap))
        headeImage.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    @objc func didtap() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
        
        
      
    }
    
    @objc func cancel() {
      dismiss(animated: true,completion: nil)
    }
    
    @objc func post() {
             guard let title = titlefield.text,
              let body = textview.text,
              let headeImage = selectedheaderimage,
              let email =  UserDefaults.standard.string(forKey: "email"),
              !title.trimmingCharacters(in: .whitespaces).isEmpty,
              !body.trimmingCharacters(in: .whitespaces).isEmpty
                else {
                 let alert = UIAlertController(title: "Enter post details", message: "enter all details", preferredStyle: .alert)
                 
                 alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel,handler: nil))
                 present(alert, animated: true)
                 return}
        
        
        let newpostid = UUID().uuidString
        let post = Blog(identifier:newpostid, title: title, date: Date().timeIntervalSince1970, headerurl: nil, text: body)
             ///upload url to the database
            storageeManager.shared.uploadblogpostheaderimage(id: newpostid, email:email , image:headeImage) { sucess in
            guard sucess else {return}
            ///dowload the url from the database
            storageeManager.shared.dowloadblogpostheaderimage(id: newpostid, email: email) { url in
                guard let headerurl = url else {return}
                
                //inser of post in db
                let post = Blog(identifier:newpostid, title: title, date: Date().timeIntervalSince1970, headerurl:headerurl, text: body)
                     ///upload url to the database
                databasemanager.shared.insertblogpost(post: post, email: email) {[weak self ] posted in
                    guard posted else {return}
                    
                    DispatchQueue.main.async {
                        self?.cancel()
                    }
                }
            }
        }
        
    }
    func configureconstraints() {
       
            let webconstraints = [
             headeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
             headeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             headeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             headeImage.widthAnchor.constraint(equalToConstant: 80),
             headeImage.heightAnchor.constraint(equalToConstant: 120),
           
                
            ]
        let webconstraints2 = [
            titlefield.bottomAnchor.constraint(equalTo: headeImage.bottomAnchor, constant: 50),
            titlefield.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            titlefield.heightAnchor.constraint(equalToConstant: 40),
            titlefield.widthAnchor.constraint(equalToConstant: 350)
       
        ]
        let webconstraints3 = [
            textview.bottomAnchor.constraint(equalTo:  titlefield.bottomAnchor, constant: 50),
            textview.heightAnchor.constraint(equalToConstant: 40),
            textview.widthAnchor.constraint(equalToConstant: 350)
          
           ]
           
        
        NSLayoutConstraint.activate(webconstraints)
        NSLayoutConstraint.activate(webconstraints2)
        NSLayoutConstraint.activate(webconstraints3)
    }
    
    
}



extension CreateViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
       
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true,completion: nil)
        
        
        guard let image = info[.originalImage] as? UIImage  else {return}
        selectedheaderimage = image
        headeImage.image = image
        
    
    }
    
    
    
}

//
//  ProfileViewController.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    private var posts: [Blog] = []
    var user:User?
    let cuurentemail:String
    
    private let tableview:UITableView = {
        
        let tableview = UITableView()
   
        tableview.register(PostHeaderTableViewCell.self, forCellReuseIdentifier: PostHeaderTableViewCell.identifier)
        return tableview
        
        
        
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
    
        fetchprofiledata()
        setupsignoutbutton()
        
        
    }
    
    init(cuurentemail: String) {
        self.cuurentemail = cuurentemail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
        
    }
    
    
    private  func headersetup(profilephotourl: URL? = nil , name: String? = nil) {
        
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width:view.frame.width, height:500))
        
        header.backgroundColor = .systemGreen
        header.clipsToBounds = true
        header.isUserInteractionEnabled = true
        tableview.tableHeaderView = header
        
        
        
        let headeImage = UIImageView(image: UIImage(systemName: "person.fill"))
        headeImage.frame  = CGRect(x: 25, y:30, width:header.frame.width - 40, height: 30)
        headeImage.contentMode = .scaleAspectFill
        headeImage.isUserInteractionEnabled = true
        headeImage.backgroundColor = .tertiarySystemBackground
        headeImage.tintColor = .white
        headeImage.translatesAutoresizingMaskIntoConstraints = false
        headeImage.layer.masksToBounds = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didtap))
        headeImage.addGestureRecognizer(tap)
        header.addSubview(headeImage)
        
        guard let currentuseremail2 = UserDefaults.standard.string(forKey: "email") else {return}
        let headelabel = UILabel()
        headelabel.frame  = CGRect(x: 200, y:headeImage.frame.minY+10, width:view.frame.width - 40, height: 30)
        headelabel.text = cuurentemail
        headelabel.tintColor = .white
        
        header.addSubview(headelabel)
        
        let headelabel2 = UILabel()
        header.addSubview(headelabel2)
        headelabel.frame  = CGRect(x: 20, y:headelabel.frame.maxY+10, width:view.frame.width - 40, height: 30)
        headelabel.text = currentuseremail2
        headelabel.tintColor = .white
        
        if let name = name {
            title = name
        }
        
        if let  profilephotourl  = profilephotourl {
            let jermaine = profilephotourl.absoluteString
            print(jermaine)
            storageeManager.shared.dowloadurlofprofileimage(path: jermaine) { url in
                guard let url = url else {return}
                let task =  URLSession.shared.dataTask(with: url) { data, _, _ in
                    guard let data = data else { return }
                    
                    DispatchQueue.main.async {
                        headeImage.image = UIImage(data: data)
                        print(data)
                    }
                }
                task.resume()
            }
            
            
            
        }
        
        
        
        
    }
    @objc func didtap() {
        guard let myemail = UserDefaults.standard.string(forKey: "email") else {return}
        
        guard  myemail == cuurentemail else {return}
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
        
    }
    
    ///fetch data from data base assign it to view using the currentmail  a document id from the signup  function to fecth the datas back to view
    private func  fetchprofiledata() {
     
         
                databasemanager.shared.getpost(for: cuurentemail) { [weak self] blog in
                    self?.posts = blog
                    DispatchQueue.main.async {
                        self?.tableview.reloadData()
                    }
                    
                }
                
            
        
        databasemanager.shared.getuser(email: cuurentemail) {[weak self] user in
            guard let user = user else {return}
            self?.user = user
            print(user)
            DispatchQueue.main.async {
                
                self?.headersetup(profilephotourl: user.profile_url, name: user.name)
            }
        }
        headersetup()
    }
    
    
    private func setupsignoutbutton() {
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "signout", style: .done, target: self, action: #selector(didTapSignOut))
    }
    ///Signout
    @objc private func didTapSignOut() {
        
        
        let sheet = UIAlertController(title: "Signout", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler:nil))
        sheet.addAction(UIAlertAction(title: "Signout", style: .destructive,handler: { sucess in
            
            AuthManager.shared.signout { sucess in
                if sucess {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(nil, forKey: "email")
                        UserDefaults.standard.set(nil, forKey: "name")
                        let signVC = SiginViewController()
                        signVC.navigationItem.largeTitleDisplayMode = .always
                        let NavVc =  UINavigationController(rootViewController: signVC)
                        NavVc.navigationBar.prefersLargeTitles  = true
                        NavVc.modalPresentationStyle = .fullScreen
                        self.present(NavVc, animated: true)
                    }
                    
                }
            }
        }))
        present(sheet, animated: true)
    }
    
    
    
    
    
}
    

   extension ProfileViewController: UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        guard  let cell = tableview.dequeueReusableCell(withIdentifier:PostHeaderTableViewCell.identifier, for: indexPath) as? PostHeaderTableViewCell else {
            
            fatalError()
        }
        cell.configure(with: postpreviewtableviewcellviewmodel(title: post.title, imageurl: post.headerurl))
        return cell
        
    }
    
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 350
       }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true,completion: nil)
        guard let image = info[.originalImage]  as? UIImage  else {return}
     
            
            
            storageeManager.shared.uploaduserprofilepicture(email: cuurentemail, image: image) { [weak self ] sucess in
                if sucess    {
                    databasemanager.shared.uploadpicture(for: self!.cuurentemail) { [weak self ]sucess in
                        if sucess {
                            
                            DispatchQueue.main.async {
                                self?.fetchprofiledata()
                            }
                        }
                    }
                }
            }
        }
       
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let vc = ViewpostViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    
    
}

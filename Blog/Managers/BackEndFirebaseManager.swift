//
//  BackEndFirebaseManager.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//

import Foundation
import FirebaseFirestore
import   UIKit

final class databasemanager {
static let shared = databasemanager()
private let database = Firestore.firestore()
    
    
    
    private init() {}
    
    public func insertblogpost(
    post:Blog,
    email:String,
    completion: @escaping (Bool) -> Void
    
    
    ){
        let ref = email.replacingOccurrences(of: ".", with: "_")
                        .replacingOccurrences(of: "@", with: ".")
            let datas = [
            "id":post.identifier ,
            "title":post.title,
            "body":post.text,
            "created":post.date,
            "headerimageurl":post.headerurl?.absoluteString ?? ""
            ] as [String : Any]
            database.collection("users").document(ref).collection("posts").document(post.identifier)
                .setData(datas) { error in
                    completion(error == nil)
                  }
                }
    public func getallpost(

    completion: @escaping (Blog) -> Void
    
    
    ){
        
        
        
    }
//    
    public func getpost(
    for email:String,
    completion: @escaping ([Blog]) -> Void
    ){
        let ref = email.replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: ".")
            database.collection("users")
            .document(ref)
            .collection("posts")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents.compactMap({$0.data()})
                        ,error == nil else {return}
                
                let posts: [Blog] = documents.compactMap({ dictionary in
                    
                    guard let id = dictionary["id"] as? String,
                          let title = dictionary["title"]as? String,
                          let body = dictionary["body"] as? String,
                          let created = dictionary["created"]as? TimeInterval,
                          let headerimageurl = dictionary["headerimageurl"]as? String else {
                        
                        
                        return nil
                        
                    }
                          
                   let post =  Blog(identifier: id,
                                title: title,
                                date: created,
                                headerurl:URL(string: headerimageurl), text: body)
               
               return post
                })
                completion(posts)
                print(posts[0])
           
            }
    }
    public func insertuser(
    for user:User,
    completion: @escaping (Bool) -> Void
    
    
    ){
        let ref = user.email.replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: ".")
        let data =
        ["email":user.email,
         "name":user.name,
         "profile_url":user.profile_url ?? ""
        ] as [String : Any]
        database.collection("users").document(ref).setData(data) {
            error in completion(error == nil)
        }
        
    }
    
    public  func getuser(email:String, completion: @escaping (User?) -> Void){
        let ref = email.replacingOccurrences(of: ".", with: "_")
                  .replacingOccurrences(of: "@", with: ".")
        database.collection("users").document(ref).getDocument { snapshot, error in
            guard let data =  snapshot?.data() as? [String: String],let name = data["name"],error == nil else
            {return}
      
         var url2:URL?
            if let urlstring =  data["profile_url"]{
                url2 = URL(string:  urlstring)
            }
            let user = User(name: name, email: email, profile_url: url2)
            completion(user)
            print(user)
        }
        
    }
    
    func uploadpicture(
        for email:String,
        completion: @escaping (Bool) -> Void
        
        
    ){
    let ref = email.replacingOccurrences(of: ".", with: "_")
                .replacingOccurrences(of: "@", with: ".")
        
        
        let photoreference =  "profile_pictures/\(ref)/photo.png"
        
        let dbref = database.collection("users").document(ref)
        
        
        dbref.getDocument { snapshot, error in
            guard var data = snapshot?.data(), error == nil else {return}
            data["profile_url"] = photoreference
            dbref.setData(data) { error in
                completion(error==nil)
                
            }
             
            
        }
        
    }
}

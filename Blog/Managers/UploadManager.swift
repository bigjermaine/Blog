//
//  UploadManager.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//

import Foundation
import FirebaseStorage
import UIKit
final class storageeManager {
    static let shared = storageeManager()
    private let database = Storage.storage()
    
    
    
    private init() {}
    
    public func uploaduserprofilepicture(email:String,image:UIImage?,completion:@escaping(Bool)-> Void) {
        let ref = email.replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: ".")
        guard let pngdata = image?.pngData() else {return}
        database.reference(withPath: "profile_pictures\(ref)/photo.png").putData(pngdata,metadata:  nil){ data, error in
            guard  data != nil , error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
        
    }
    
    public func dowloadurlofprofileimage(path:String,completion:@escaping(URL?)-> Void)  {
        
        database.reference(withPath: path).downloadURL { url, _ in
            completion(url)
        }
    }
    
    func uploadblogpostheaderimage(id:String,email:String ,image:UIImage?,completion:@escaping(Bool)-> Void){
        
        let ref = email.replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: ".")
        guard let pngdata = image?.pngData() else {return}
        database.reference(withPath: "posts_headers\(ref)/\(id).png").putData(pngdata,metadata:  nil){ data, error in
            guard  data != nil , error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
        
    }
        
        
        
    
    func dowloadblogpostheaderimage(id:String,email:String,completion:@escaping(URL?)-> Void){
        let ref = email.replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: ".")
      
        database.reference(withPath: "posts_headers\(ref)/\(id).png").downloadURL{ url, error in
        
        completion(url)
          }
        }
    }

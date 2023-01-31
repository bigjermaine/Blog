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
    private let database = Storage.storage().reference()
    
    
    
    private init() {}
    
    public func uploaduserprofilepicture(email:String,image:UIImage?,completion:@escaping(Bool)-> Void) {
        
        
        
    }
    
    public func dowloadurlofprofileimage(user:User,completion:@escaping(URL?)-> Void)  {
        
        
    }
    func uploadblogpostheaderimage(Blogpost:Blog,image:UIImage?,completion:@escaping(Bool)-> Void){}
    func dowloadblogpostheaderimage(Blogpost:Blog,image:UIImage?,completion:@escaping(Bool)-> Void){}
}

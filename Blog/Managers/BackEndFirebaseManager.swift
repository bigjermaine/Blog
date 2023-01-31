//
//  BackEndFirebaseManager.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//

import Foundation
import FirebaseFirestore


final class databasemanager {
static let shared = databasemanager()
private let database = Firestore.firestore()
    
    
    
    private init() {}
    
    public func insertblogpost(
    with post:Blog,
    user:User,
    completion: @escaping (Bool) -> Void
    
    
    ){
        
        
        
    }
    public func getallpost(

    completion: @escaping (Blog) -> Void
    
    
    ){
        
        
        
    }
    
    public func getallpost(
    for user:User,
    completion: @escaping (Blog) -> Void
    
    
    ){
        
        
        
    }
    public func insertuser(
    for user:String,
    completion: @escaping (Blog) -> Void
    
    
    ){
        
        
        
    }
}

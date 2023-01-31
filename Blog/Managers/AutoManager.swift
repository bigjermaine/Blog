//
//  AutoManager.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//

import Foundation
import FirebaseAuth



final class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    
    
    
    public init() {}
   
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    
    public func signup(email: String, password:String, completion: @escaping (Bool)-> Void ){
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {return}
            
        auth.createUser(withEmail: email, password: password) {
            Result,error in
            
            guard Result != nil , error == nil  else {
                
                completion(false)
                return
            }
            completion(true)
        }
    }
        
    
    
    public func signin(email: String, password:String, completion: @escaping (Bool)-> Void ){
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {return}
        auth.signIn(withEmail: email, password: password) {
            Result,error in
            
            guard Result != nil , error == nil  else {
                
                completion(false)
                return
            }
            completion(true)
         
        }
        
    }
    public func signout( completion: @escaping (Bool)-> Void ){
        
        do {
            try auth.signOut()
            completion(true)
        }catch{
            completion(false)
        }
        
    }
    
    
    
}

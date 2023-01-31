//
//  User:Blog.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//

import Foundation

struct User {
    
    let name:String
    let email:String
    let profileurl:URL?
}

struct Blog {
    let identifier: String
    let title:String
    let date: TimeInterval
    let headerurl:URL?
    let text:String
}

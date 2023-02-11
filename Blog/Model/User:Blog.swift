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
    let profile_url:URL?
    init(name: String, email: String, profile_url: URL?) {
        self.name = name
        self.email = email
        self.profile_url = profile_url
    }
}

struct Blog {
    let identifier: String
    let title:String
    let date: TimeInterval
    let headerurl:URL?
    let text:String
    
    init(identifier: String, title: String, date: TimeInterval, headerurl: URL?, text: String) {
        self.identifier = identifier
        self.title = title
        self.date = date
        self.headerurl = headerurl
        self.text = text
    }
}

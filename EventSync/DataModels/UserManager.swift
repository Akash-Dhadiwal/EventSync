//
//  UserManager.swift
//  EventSync
//
//  Created by Akash Dhadiwal on 11/30/25.
//


class UserManager {
    static let shared = UserManager()
    
    var loggedInUser: User?
    
    private init() {} 
}

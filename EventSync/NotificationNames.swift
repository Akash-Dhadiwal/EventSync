//
//  NotificationName.swift
//  EventSync
//
//  Created by Akash Dhadiwal on 12/02/25.
//

import Foundation

extension Notification.Name {
    static let selectState = Notification.Name("selectState")
    static let selectCity = Notification.Name("selectCity")
    static let loggedIn = Notification.Name("loggedIn")
    static let registered = Notification.Name("registered")
    static let selectStateCreatePost = Notification.Name("selectStateInCreatePost")
    static let selectCityCreatePost = Notification.Name("selectCityInCreatePost")
    static let contentEdited = Notification.Name("contentEdited")
    static let likeUpdated = Notification.Name("likeUpdated")
    static let newEventAdded = Notification.Name("newEventAdded")
}

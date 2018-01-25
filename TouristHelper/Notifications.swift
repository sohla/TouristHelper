//
//  Notifications.swift
//  TouristHelper
//
//  Created by Stephen OHara on 25/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import Foundation

extension Notification.Name {

    static let locationSelected = Notification.Name("locationSelected")
    static let currentLocationUpdated = Notification.Name("currentLocationUpdated")
    static let authorizationStatusChanged = Notification.Name("authorizationStatusChanged")

}

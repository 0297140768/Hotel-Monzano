//
//  Registration.swift
//  Hotel Monzano
//
//  Created by Татьяна on 18.10.2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}

struct RoomType {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
}

extension RoomType: Equatable {
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}

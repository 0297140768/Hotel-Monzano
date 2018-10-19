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
    
    static func createRooms() -> [RoomType] {
        let rooms = [
            RoomType(id: 1, name: "Одноместный номер", shortName: "SGL", price: 50),
            RoomType(id: 2, name: "Двухместный номер с одной большой кроватью", shortName: "Double room", price: 100),
            RoomType(id: 3, name: "Двухместный номер с двумя кроватями", shortName: "Twin", price: 150),
            RoomType(id: 4, name: "Люкс", shortName: "Suite", price: 200)]
        
        return rooms
    }

}

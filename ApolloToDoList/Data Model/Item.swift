//
//  Item.swift
//  ApolloToDoList
//
//  Created by Arseniy Apollonov on 12.10.2022.
//

import Foundation

class Item: Encodable {
    var title: String = ""
    var done: Bool = false
}

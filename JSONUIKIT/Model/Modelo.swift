//
//  Modelo.swift
//  JSONUIKIT
//
//  Created by Paul Jaime Felix Flores on 25/04/23.
//

//Paso 1.4, es el mismo modelo que para UIKIT
import Foundation

struct Modelo : Decodable {
    var data : [UserList]
}

struct User : Decodable{
    var data : UserList
}

struct UserList : Decodable {
    var id : Int
    var first_name : String
    var email : String
    var avatar : String
}

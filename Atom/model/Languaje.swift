//
//  Languaje.swift
//  Atom
//
//  Created by Mikhail Polozhaev on 02/09/2020.
//  Copyright © 2020 Mikhail Polozhaev. All rights reserved.
//

struct Languaje:Decodable {
    let id:String
    let name:String
    
    enum CodingKeys: String, CodingKey {
        case id = "iso_639_1"
        case name
    }
}

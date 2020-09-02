//
//  Genre.swift
//  Atom
//
//  Created by Mikhail Polozhaev on 02/09/2020.
//  Copyright © 2020 Mikhail Polozhaev. All rights reserved.
//

struct Genre:Decodable {
    let id:Int
    let name:String
    
    enum CodingKeys: String, CodingKey {
          case id
          case name
      }
}

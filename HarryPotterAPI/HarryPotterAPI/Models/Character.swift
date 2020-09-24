//
//  Character.swift
//  HarryPotterAPI
//
//  Created by Trevor Bursach on 9/23/20.
//

import Foundation

struct Character: Decodable {
    let name: String
    let species: String
    let gender: String
    let house: String?
    let dateOfBirth: String?
    let ancestry: String?
    let eyeColour: String?
    let hairColour: String
    let image: String?
    let wand: Wand?
}

struct Wand: Decodable {
    let wood: String?
    let core: String?
//    let length: Int?
}

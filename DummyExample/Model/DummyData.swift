//
//  DummyData.swift
//  DummyExample
//
//  Created by Allan Evans on 12/17/22.
//

import Foundation

struct DummyData:Codable{
    
    let id:Int
    let title:String
    let description:String
    let price:Int
    let discountPercentage:Double
    let rating:Double
    let stock:Int
    let brand:String
    let category:String
    let thumbnail:String
    let images: [String]
    }

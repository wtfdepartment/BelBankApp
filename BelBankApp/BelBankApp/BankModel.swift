//
//  BankModel.swift
//  BelBankApp
//
//  Created by Александра on 30.01.23.
//

import Foundation
import ObjectMapper

// MARK: BankModel
class BankModel: Mappable {
    var id: String?
    var area: String?
    var work_time: String?
    var currency: String?
    var lat: String?
    var lon: String?
    var city: String?
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id          <- map["id"]
        area        <- map["area"]
        work_time   <- map["work_time"]
        currency    <- map["currency"]
        lat         <- map["gps_x"]
        lon         <- map["gps_y"]
        city        <- map["city"]
    }
}
// MARK: GemModel
class GemModel: Mappable {
    var gemNumberOfAttestat: String = ""
    var gemForm: String = ""
    var gemWorkTime: String = ""
    var gemWeight: String = ""
    var gemColor: String = ""
    var gemCost: String = ""
    var gemFilialID: String = ""
    var gemCityName: String = ""
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        gemNumberOfAttestat  <- map["attestat"]
        gemForm              <- map["name_ru"]
        gemWorkTime          <- map["grani"]
        gemWeight            <- map["weight"]
        gemColor             <- map["color"]
        gemCost              <- map["cost"]
        gemFilialID          <- map["filial_id"]
        gemCityName          <- map["name"]
    }
}

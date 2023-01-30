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
// MARK: FillialModel
class FillialModel: Mappable {
    
    var filialName: String = ""
    var nameType: String = ""
    var name: String = ""
    var streetType: String = ""
    var street: String = ""
    var homeNumber: String = ""
    var phone: String = ""
    var latitude = ""
    var longitude = ""
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        filialName <- map["filial_name"]
        nameType   <- map["name_type"]
        name       <- map["name"]
        streetType <- map["street_type"]
        street     <- map["street"]
        homeNumber <- map["home_number"]
        latitude   <- map["GPS_X"]
        longitude  <- map["GPS_Y"]
    }
    
}
// MARK: ATMModel
class ATMModel: Mappable {
    
    var id = ""
    var cityType = ""
    var city = ""
    var addressType = ""
    var address = ""
    var house = ""
    var workTime = ""
    var latitude = ""
    var longitude = ""
    
    required init?(map: ObjectMapper.Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id          <- map["id"]
        cityType    <- map["city_type"]
        city        <- map["city"]
        addressType <- map["address_type"]
        address     <- map["address"]
        house       <- map["house"]
        workTime    <- map["work_time"]
        latitude    <- map["gps_x"]
        longitude   <- map["gps_y"]
    }
}

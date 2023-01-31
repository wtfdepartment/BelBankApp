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
// MARK: MetalModel
class MetalModel: Mappable {
    var gold10 = ""
    var gold20 = ""
    var gold50 = ""
    var silver10 = ""
    var silver20 = ""
    var silver50 = ""
    var platinum10 = ""
    var platinum20 = ""
    var platinum50 = ""
    var streetType = ""
    var street = ""
    var fillialName = ""
    var homeNumber = ""
    var city = ""
    var cityType = ""
    
    required init?(map: ObjectMapper.Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        gold10      <- map["ZOL_10_out"]
        gold20      <- map["ZOL_20_out"]
        gold50      <- map["ZOL_50_out"]
        silver10    <- map["SIL_10_out"]
        silver20    <- map["SIL_20_out"]
        silver50    <- map["SIL_50_out"]
        platinum10  <- map["PL_10_out"]
        platinum20  <- map["PL_20_out"]
        platinum50  <- map["PL_50_out"]
        streetType  <- map["street_type"]
        street      <- map["street"]
        fillialName <- map["filials_text"]
        homeNumber  <- map["home_number"]
        city        <- map["name"]
        cityType    <- map["name_type"]
    }
}

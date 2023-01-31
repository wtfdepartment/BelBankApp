//
//  BankAPI.swift
//  BelBankApp
//
//  Created by Александра on 30.01.23.
//

import Foundation
import Moya

enum BankAPI {
    case adress
    case gem
    case fillials
    case metals
    case atm(city: String)
}

extension BankAPI: TargetType{
    var baseURL: URL {
        return URL(string: "https://belarusbank.by/api")!
    }
    
    var path: String {
        switch self {
            case .adress, .atm:
                return "/atm"
            case .gem:
                return "/getgems"
            case .fillials:
                return "/filials_info"
            case .metals:
                return "/getinfodrall"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .adress, .gem, .atm, .fillials, .metals:
                return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        
        switch self {
            case .adress, .gem, .fillials, .metals:
                return nil
//                params["city"] = ""
            case .atm(let city):
                params["city"] = city
        }
        
        return params
    }
    
    var encoding: ParameterEncoding {
        switch self {
            case .adress, .gem, .atm, .fillials, .metals:
                return URLEncoding.queryString
        }
    }
    
    
}

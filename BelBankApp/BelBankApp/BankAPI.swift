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
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .adress, .gem, .atm:
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
            case .adress, .gem:
                return nil
//                params["city"] = ""
            case .atm(let city):
                params["city"] = city
        }
        
        return params
    }
    
    var encoding: ParameterEncoding {
        switch self {
            case .adress, .gem, .atm:
                return URLEncoding.queryString
        }
    }
    
    
}

//
//  BankProvider.swift
//  BelBankApp
//
//  Created by Александра on 30.01.23.
//

import Foundation
import Moya
import Moya_ObjectMapper

final class BelarusBankProvider {
    private let provider = MoyaProvider<BankAPI>(plugins: [NetworkLoggerPlugin()])
    
    func bankAdress(bankBlock: @escaping ([BankModel]) -> Void, failure: (() -> Void)? = nil) {
        provider.request(.adress) { result in
            switch result {
                case .success(let response):
                    guard let adress = try? response.mapArray(BankModel.self) else { return }
                    bankBlock(adress)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    failure?()
            }
        }
    }
    
    func atmAdressByCity(city: String, bankBlock: @escaping ([BankModel]) -> Void, failure: (() -> Void)? = nil){
        provider.request(.atm(city: city)) { result in
            switch result {
                case .success(let response):
                    guard let adress = try? response.mapArray(BankModel.self) else { return }
                    bankBlock(adress)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    failure?()
            }
        }
    }
    
    func getATMs(city: String, bankBlock: @escaping ([ATMModel]) -> Void, failure: (() -> Void)? = nil){
        provider.request(.atm(city: "")) { result in
            switch result {
                case .success(let response):
                    guard let adress = try? response.mapArray(ATMModel.self) else { return }
                    bankBlock(adress)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    failure?()
            }
        }
    }
    
    func getFillials(city: String, bankBlock: @escaping ([FillialModel]) -> Void, failure: (() -> Void)? = nil){
        provider.request(.fillials) { result in
            switch result {
                case .success(let response):
                    guard let adress = try? response.mapArray(FillialModel.self) else { return }
                    bankBlock(adress)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    failure?()
            }
        }
    }
}

final class GemProvider {
    private let provider = MoyaProvider<BankAPI>(plugins: [NetworkLoggerPlugin()])
    
    func gemData(bankBlock: @escaping ([GemModel]) -> Void, failure: (() -> Void)? = nil) {
        provider.request(.gem) { result in
            switch result {
                case .success(let response):
                    guard let adress = try? response.mapArray(GemModel.self) else { return }
                    bankBlock(adress)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    failure?()
            }
        }
    }
    
    func getMetals(success: @escaping (([MetalModel]) -> Void), failure: ((String) -> Void)?) {
        provider.request(.metals) { result in
            switch result {
                case .success(let response):
                    guard let result = try? response.mapArray(MetalModel.self) else { return }
                    
                    success(result)
                case .failure(let error):
                    guard let description = error.errorDescription else { return }
                    
                    failure?(description)
            }
        }
    }
}

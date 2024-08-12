//
//  CallMoyaExample.swift
//  Drink-EG
//
//  Created by 김도연 on 8/11/24.
//

import Foundation
import Moya

// ViewController에서 provider 선언
let provider = MoyaProvider<BasicAPI>()

// GET example
//provider.request(.getUser(id: 1)) { result in
//    switch result {
//    case .success(let response):
//        do {
//            let data = try response.mapJSON()
//            print("User Data: \(data)")
//        } catch {
//            print("Failed to map data: \(error)")
//        }
//    case .failure(let error):
//        print("Request failed: \(error)")
//    }
//}

// POST
//provider.request(.createUser(name: "John Doe", email: "john@example.com")) { result in
//    switch result {
//    case .success(let response):
//        do {
//            let data = try response.mapJSON()
//            print("User Created: \(data)")
//        } catch {
//            print("Failed to map data: \(error)")
//        }
//    case .failure(let error):
//        print("Request failed: \(error)")
//    }
//}

// PUT
//provider.request(.updateUser(id: 1, name: "Jane Doe", email: "jane@example.com")) { result in
//    switch result {
//    case .success(let response):
//        do {
//            let data = try response.mapJSON()
//            print("User Updated: \(data)")
//        } catch {
//            print("Failed to map data: \(error)")
//        }
//    case .failure(let error):
//        print("Request failed: \(error)")
//    }
//}

// DELETE
//provider.request(.deleteUser(id: 1)) { result in
//    switch result {
//    case .success(let response):
//        print("User Deleted")
//    case .failure(let error):
//        print("Request failed: \(error)")
//    }
//}

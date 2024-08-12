//
//  LoginAPI.swift
//  Drink-EG
//
//  Created by 김도연 on 8/12/24.
//

import Foundation
import Moya

struct JoinNLoginRequest : Codable {
    let username : String
    let password : String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

enum LoginAPI {
    case postLogin(data: JoinNLoginRequest)
    case postRegister(data : JoinNLoginRequest)
}

extension LoginAPI: TargetType {
    var baseURL: URL {
        /// 기본 URL 작성
        return URL(string: "https://drinkeg.com")!
    }
    
    var path: String {
        /// 기본 URL + path 로 URL 구성
        switch self {
            /// 동일한 path는 한 case로 처리 가능
        case .postLogin:
            return "/login"
        case .postRegister:
            return "/join"
        }
    }
    
    var method: Moya.Method {
        /// 각 case 별로 적합한 method 배정
        switch self {
        case .postLogin:
            return .get
        case .postRegister:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .postLogin(let data), .postRegister(let data) :
            return .requestJSONEncodable(data)
        }
    }
    
    // API 호출 시, header에 token 넣어서 전달
    var headers: [String : String]? {
        let jwtToken = "jwt_token_here"
        return [
            "Authorization": "Bearer \(jwtToken)",
            "Content-type": "application/json"
        ]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

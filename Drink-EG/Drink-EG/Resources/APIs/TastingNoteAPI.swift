//
//  BasicAPI.swift
//  Drink-EG
//
//  Created by 김도연 on 8/11/24.
//

import Foundation
import Moya

// JWT 토큰을 받을 수 있도록 BasicAPI 정의
/// 기능 하나 당 API 1개씩 만들기
/// - API 명세서 기준으로 1 명세서 당 1 API enum 정의하기
/// - 변경을 한 번 더 해보자.

enum TastingNoteAPI {
    case getAllNotes
    case getWineName(wineName: String)
    
}

extension TastingNoteAPI: TargetType {
    var baseURL: URL {
        /// 기본 URL 작성
        return URL(string: "https://drinkeg.com/tasting-note/")!
    }
    
    var path: String {
        /// 기본 URL + path 로 URL 구성
        switch self {
            /// 동일한 path는 한 case로 처리 가능
        case .getWineName(let wineName):
            return "\(wineName)"
        case .getAllNotes:
            return "all-note"
        }
    }
    
    var method: Moya.Method {
        /// 각 case 별로 적합한 method 배정
        switch self {
        case .getWineName:
            return .get
        case .getAllNotes:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getWineName(let wineName):
            return .requestParameters(parameters: ["wineName": wineName], encoding: JSONEncoding.default)
        case .getAllNotes:
            return .requestPlain
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


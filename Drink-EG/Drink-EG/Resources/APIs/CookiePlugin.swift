//
//  AuthPlugin.swift
//  Drink-EG
//
//  Created by 김도연 on 8/11/24.
//

import Foundation
import Moya

// 토큰 추가 플러그인 정의
final class CookiePlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        // 저장된 쿠키를 가져와서 헤더에 추가
        if let cookies = HTTPCookieStorage.shared.cookies {
            let cookieHeader = HTTPCookie.requestHeaderFields(with: cookies)
            for (key, value) in cookieHeader {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}


//let provider = MoyaProvider<MemberInfoAPI>(plugins: [CookiePlugin()])
//
//// API 호출
//provider.request(.patchMember(data: memberInfo)) { result in
//    switch result {
//    case .success(let response):
//        // 성공적인 응답 처리
//        print("Success: \(response)")
//    case .failure(let error):
//        // 실패 처리
//        print("Error: \(error)")
//    }
//}

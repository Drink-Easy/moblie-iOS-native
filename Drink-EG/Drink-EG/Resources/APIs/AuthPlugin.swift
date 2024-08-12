//
//  AuthPlugin.swift
//  Drink-EG
//
//  Created by 김도연 on 8/11/24.
//

import Foundation
import Moya

// 토큰 추가 플러그인 정의
final class AuthPlugin: PluginType {
    let token: String

    init(token: String) {
        self.token = token
    }

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}

//let jwtToken = "your_jwt_token_here"
//let authPlugin = AuthPlugin(token: jwtToken)
//let provider = MoyaProvider<MyAPI>(plugins: [authPlugin])

//provider.request(.getUser(id: 1)) { result in
//    // Handle result as before
//}

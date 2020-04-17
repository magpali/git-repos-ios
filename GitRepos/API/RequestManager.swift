//
//  File.swift
//  GitRepos
//
//  Created by Victor Magpali on 15/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

import Alamofire
import RxSwift
import Foundation


class RequestManager {
    
    class func request<T>(with router: Router) -> Single<T> where T: Decodable {
        let single = Single<T>.create { single -> Disposable in
            AF.request(router.url, method: router.method)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseDecodable { (response: DataResponse<T, AFError>) in
                    switch response.result {
                    case .success(let decodable):
                        single(.success(decodable))
                    case .failure(let error):
                        single(.error(error))
                    }
            }
            
            return Disposables.create()
        }
        
        return single
        

    }
    
}

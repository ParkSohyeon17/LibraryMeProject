//
//  ApiService.swift
//  LibraryMeProject
//
//  Created by 박소현 on 2023/10/18.
//

import Alamofire
import SwiftyJSON

class ApiService {
    
    var isLastLibraryItem = false
    
    var isPaging = false
    
    var libraryItemReqCnt = 0
    
    func getLibraryList(completion: @escaping(Library?) -> ()) {
        
        let requestUrl = String(format: Constants.baseUrl, libraryItemReqCnt)
        print("요청 url :: \(requestUrl)")
        
        AF.request(requestUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseDecodable(of: Library.self) { response in

            let statusCode = response.response?.statusCode ?? -1
            print("statusCode :: \(statusCode)")

            print("response :: \(JSON(response.data as Any))")
            if let library = response.value {
                
                let libraryListCnt = library.data.list.count
                if libraryListCnt == 0 || libraryListCnt < 20 {
                    self.libraryItemReqCnt = 0
                    self.isLastLibraryItem = true
                }

                completion(library)
            }
            else if let error = response.error {
                print("error :: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
    }
    
}

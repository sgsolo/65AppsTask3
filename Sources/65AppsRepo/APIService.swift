//
//  APIService.swift
//  65AppsRepo
//
//  Created by Григорий Соловьев on 11.03.2019.
//

import Foundation
import Alamofire

protocol APIService {
    func getRepo(nickName: String, completion: @escaping ([String]) -> Void)
}

struct APIServiceImp: APIService {
    
    let baseUrlString = "https://api.github.com/search/repositories?sort=stars&order=desc&q="
    
    func getRepo(nickName: String, completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: baseUrlString + nickName) else { return }
        let request = Alamofire.request(url)
        request.response { (response) in
            if let data = response.data,
                let repositories = try? JSONDecoder().decode(Repositories.self, from: data),
                let items = repositories.items {
                completion(items.compactMap { $0.name })
            } else {
                completion([])
            }
        }
    }
}

struct Repositories: Decodable {
    let items: [RepoItem]?
}

struct RepoItem: Decodable {
    let name: String?
}

//
//  HomeService.swift
//  rickandmorty
//
//  Created by Edno Fedulo on 05/12/20.
//  Copyright © 2020 Edno Fedulo. All rights reserved.
//

import Foundation

protocol HomeServiceProtocol:AnyObject {
    func fetchData(from url:String, completionHandler: @escaping(_ homeModel: RequestModel<CharacterModel>?, _ error: String?) -> Void)
}

class HomeService: HomeServiceProtocol {
    func fetchData(from url:String, completionHandler: @escaping (RequestModel<CharacterModel>?, String?) -> Void) {
        guard let url = URL(string:url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in

            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(nil, error?.localizedDescription)
                }
                
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                DispatchQueue.main.async {
                    completionHandler(nil, "erro desconhecido")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, "Nenhuma informação foi obtida")
                }
                return
            }
            
            let request = try? JSONDecoder().decode(RequestModel<CharacterModel>.self, from: data)
            DispatchQueue.main.async {
                completionHandler(request, nil)
            }
        }

        task.resume()
    }
}

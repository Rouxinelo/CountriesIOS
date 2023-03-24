//
//  CountryMenuNetworkLayer.swift
//  CountryInfo
//
//  Created by João Rouxinol on 24/03/2023.
//

import Foundation

protocol CountryMenuNetworkLayerProtocol {
    func fetchData(_ completion: @escaping (_ success: Bool, _ data: [CountryModel]?) -> Void)
}

struct CountryMenuNetworkLayer: CountryMenuNetworkLayerProtocol {
    let url = "https://restcountries.com/v3.1/all"
    
    func fetchData(_ completion: @escaping (_ success: Bool, _ data: [CountryModel]?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let countries = self.parseCountryModelJSON(data: data) {
             completion(true, countries)
          } else {
             completion(false, nil)
          }
       }
       task.resume()
    }

    func parseCountryModelJSON(data: Data) -> [CountryModel]? {
        do {
            let data = try JSONDecoder().decode([CountryModel].self, from: data)
            return data
        } catch {
            print(error)
            return nil
        }
    }
}


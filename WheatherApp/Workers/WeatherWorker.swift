//
//  WeatherWorkers.swift
//  WheatherApp
//
//  Created by Yerassyl on 13.04.2024.
//

import Foundation

typealias Failure = (Any) -> Void
typealias Success<T> = (T) -> Void

final class WeatherWorker{
    
    private var APIKey = "bd8cfbc3189741dc98865401242804"
    
    func getCurrent(city: String ,
                    failure: @escaping (Failure),
                    success: @escaping Success<Current>) {
        
        let parametres = ["key": APIKey,"q": city]
        NetworkManager.shared.fetchDate(from: "current.json", parameters: parametres) { result in
            
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    
                    let result: Current = try jsonDecoder.decode(Current.self, from: data)
                    success(result)
                } catch {
                    print("Error: \(error)")
                }
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func getForecast(city: String,
                     failure: @escaping (Failure),
                     success: @escaping Success<Forecast>){
        
        let parametres: [String : Any ] = ["key" :APIKey , "q": city, "days": 4]
        NetworkManager.shared.fetchDate(from: "forecast.json", parameters: parametres) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    let result: Forecast = try jsonDecoder.decode(Forecast.self, from: data)
                    success(result)
                }catch {
                    print("Error: \(error)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

//
//  ViewController.swift
//  WheatherApp
//
//  Created by Yerassyl on 12.04.2024.
//

import UIKit

//4595d63a58a9400488973348241204

class ViewController: UIViewController {
    
    var current: Current?
    
    private lazy var cityName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherType: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageOfWeather: UIImage = {
        let imageOfWeather = UIImage()
        return imageOfWeather
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    
    var weatherWorker: WeatherWorker = WeatherWorker()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        //let view
        loadDataCurrent()
        loadDataForecast()
    }
    func loadDataCurrent(){
        weatherWorker.getCurrent(city: "Shymkent", failure: { error in
            print(error)
        }, success: { current in
            print(current.location.country)
            print(current.location.name)
            print(current.current.tempC)
            print(current.current.isDay)
        })
    }
    func loadDataForecast(){
        weatherWorker.getForecast(city: "Astana", failure: { error in
            print(error)
        }, success: { forecast in
            print(forecast.forecast.forecastday.first?.date ?? "none")
            print(forecast.forecast.forecastday.first?.hour.first?.windDir ?? "none")
            print(forecast.forecast.forecastday.last?.dateEpoch ?? "none")
            print(forecast.current.isDay)
            print(forecast.location.name)
            print(forecast.current.windMph)
            print(forecast.forecast.forecastday.first?.day)
        })
    }
}


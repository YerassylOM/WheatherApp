//
//  ViewController.swift
//  WheatherApp
//
//  Created by Yerassyl on 12.04.2024.
//

import SnapKit
import UIKit

//4595d63a58a9400488973348241204

class ViewController: UIViewController {
    
    var current: Current?
    
    
    private lazy var cityName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 45)
        label.text = "California"
        return label
    }()
    
    private lazy var weatherType: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 20)
        label.text = "Cloudly"
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 30)
        label.text = "20C"
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 25)
        label.text = "April 28-2024"
        return label
    }()
    
    private lazy var imageOfWeather: UIImageView = {
        let imageOfWeather = UIImageView()
        imageOfWeather.image = UIImage(systemName: "sun.min.fill")
        return imageOfWeather
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var imageForBackground: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image")
        return image
    }()
    
    
    var weatherWorker: WeatherWorker = WeatherWorker()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        constraints()
        loadDataCurrent()
        loadDataForecast()
    }
    
    func setupViews(){
        view.insertSubview(imageForBackground, at: 0)
        view.addSubview(cityName)
        view.addSubview(weatherType)
        view.addSubview(tempLabel)
        view.addSubview(dateLabel)
        view.addSubview(imageOfWeather)
        view.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
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
    func constraints() {
        imageForBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cityName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        weatherType.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        imageOfWeather.snp.makeConstraints { make in
            make.top.equalTo(weatherType.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(imageOfWeather.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(300)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        return cell
    }
    
    
    
}

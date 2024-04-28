//
//  TableViewCell.swift
//  WheatherApp
//
//  Created by Yerassyl on 28.04.2024.
//

import SnapKit
import UIKit

class TableViewCell: UITableViewCell {
    
    private lazy var dayName: UILabel = {
        let label = UILabel()
        label.text = "Monday"
        label.font = UIFont(name: "Arial", size: 25)
        return label
    }()
    
    private lazy var imageOfWeather: UIImageView = {
        let imageOfWeather = UIImageView()
        return imageOfWeather
    }()
    
    private lazy var tempInDay: UILabel = {
        let label = UILabel()
        label.text = "15"
        return label
    }()
    
    private lazy var tempInNight: UILabel = {
        let label = UILabel()
        label.text = "15"
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        contentView.addSubview(dayName)
        contentView.addSubview(imageOfWeather)
        contentView.addSubview(tempInDay)
        contentView.addSubview(tempInNight)
        contentView.backgroundColor = UIColor.clear
    }
    
    func constraints() {
        dayName.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
        }
        imageOfWeather.snp.makeConstraints { make in
            make.leading.equalTo(dayName.snp.trailing).offset(30)
            make.size.equalTo(25)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        tempInDay.snp.makeConstraints { make in
            make.leading.equalTo(imageOfWeather.snp.trailing).offset(25)
            make.centerY.equalToSuperview()
            make.width.equalTo(15)
        }
        tempInNight.snp.makeConstraints { make in
            make.leading.equalTo(tempInDay.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(15)
        }
    }
}

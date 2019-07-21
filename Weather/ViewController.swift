//
//  ViewController.swift
//  Weather
//
//  Created by Kelvin Fok on 21/7/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchWeatherViaTextFieldEditingEnd()
        // fetchWeatherViaTextFieldInput()
        }
    
    private func fetchWeatherViaTextFieldEditingEnd() {
        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map({ self.cityNameTextField.text })
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    private func fetchWeatherViaTextFieldInput() {
        cityNameTextField.rx.value
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }

    
    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp)"
            self.humidityLabel.text = "\(weather.humidity)"
        } else {
            self.temperatureLabel.text = "🤒"
            self.humidityLabel.text = "🤒"
        }
    }
    
    private func fetchWeather(by city: String) {
        
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }
        
        let resource = Resource<WeatherResult>.init(url: url)
        
//        URLRequest.load(resource: resource)
//            .observeOn(MainScheduler.instance)
//            .catchErrorJustReturn(.empty)
//            .subscribe(onNext: { result in
//                let weather = result.main
//                self.displayWeather(weather)
//            }).disposed(by: disposeBag)

        
// Method 2:
//        let search = URLRequest.load(resource: resource)
//            .observeOn(MainScheduler.instance)
//            .catchErrorJustReturn(.empty)
//
//        search.map { "\($0.main.temp)"}
//            .bind(to: self.temperatureLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        search.map { "\($0.main.humidity)"}
//            .bind(to: self.humidityLabel.rx.text)
//            .disposed(by: disposeBag)

// Method 3
//        let search = URLRequest.load(resource: resource)
//            .asDriver(onErrorJustReturn: .empty)
//
//        search.map { "\($0.main.temp)"}
//            .drive(self.temperatureLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        search.map { "\($0.main.humidity)"}
//            .drive(self.humidityLabel.rx.text)
//            .disposed(by: disposeBag)
        
        
        // Method 4
        
        let search = URLRequest.loadWithErrorHandling(resource: resource)
            .observeOn(MainScheduler.instance)
            .retry(10)
            .catchError { (error) in
                print("error!: \(error.localizedDescription)")
                return Observable.just(WeatherResult.empty)
        }.asDriver(onErrorJustReturn: WeatherResult.empty)
        
        search.map { "\($0.main.temp)"}
            .drive(self.temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map { "\($0.main.humidity)"}
            .drive(self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    

}


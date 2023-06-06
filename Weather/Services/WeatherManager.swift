//
//  WeatherService.swift
//  Weather
//
//  Created by Moody on 2023-06-05.
//

import Foundation

class WeatherManager {
    private let apiKey = "0b69852fc73a9f3cfde8639ec1f8ca5c"
    private let baseURL = "https://api.openweathermap.org/data/2.5/forecast?"
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping ([Weather]) -> Void) {
        let requestURL = "\(baseURL)lat=\(latitude)&lon=\(longitude)&exclude=current,minutely,hourly,alerts&units=metric&cnt=30&appid=\(apiKey)"
        
        if let url = URL(string: requestURL) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                        let weatherArray = self.groupForecastByDate(weatherResponse.list)
                        completion(weatherArray)
                    } catch {
                        print("Error decoding JSON: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    }
    
    private func groupForecastByDate(_ forecastList: [Weather]) -> [Weather] {
        var groupedForecast = [Weather]()
        var currentDay: String?
        
        for forecast in forecastList {
            let date = dateString(from: forecast.date)
            if date != currentDay {
                currentDay = date
                groupedForecast.append(forecast)
            }
        }
        
        return groupedForecast
    }
    
    private func dateString(from timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: date)
    }
}

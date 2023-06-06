//
//  WeatherCard.swift
//  Weather
//
//  Created by Moody on 2023-06-05.
//

import SwiftUI

struct WeatherCard: View {
    let weather: Weather

    var body: some View {
        VStack (spacing: 32) {
            Spacer()
            Text(dateString(from: weather.date))
                .font(.custom("Raleway-Medium", size: 25.0))
            HStack {
                Spacer()
                Image(systemName: "thermometer.high")
                    .font(.largeTitle)
                Text("\(weather.main.tempMax, specifier: "%.1f")°")
                    .font(.custom("Raleway-Bold", size: 45.0))
                Spacer()
            }
            HStack {
                Spacer()
                Image(systemName: "thermometer.low")
                    .font(.largeTitle)
                Text("\(weather.main.tempMin, specifier: "%.1f")°")
                    .font(.custom("Raleway-Bold", size: 45.0))
                Spacer()
            }
            Text("Precipitation: \(weather.pop * 100, specifier: "%.1f")%")
                .font(.custom("Raleway-Regular", size: 15.0))
            Spacer()
        }
        .padding()
    }
    
    private func dateString(from timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: date)
    }
}

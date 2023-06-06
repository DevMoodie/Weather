//
//  WeatherView.swift
//  Weather
//
//  Created by Moody on 2023-06-05.
//

import SwiftUI

struct WeatherView: View {
    @State private var weatherData: [Weather] = []
    let weatherManager = WeatherManager()

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Text("New York")
                        .font(.custom("Raleway-Bold", size: 22.0))
                        .foregroundColor(.mint)
                        .padding()
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action: {
                        refreshWeather()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.body.bold())
                            .foregroundColor(.mint)
                            .opacity(0.7)
                            .padding()
                    }
                    .padding()
                }
            }
            Spacer()
            TabView {
                ForEach(weatherData, id: \.date) { weather in
                    WeatherCard(weather: weather)
                        .background(Color.mint.opacity(0.12))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .tabViewStyle(PageTabViewStyle())
            .foregroundColor(.black)
            Spacer()
            
            Text("Powered by OpenWeatherMap API")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(16)
        }
        .onAppear(perform: refreshWeather)
    }
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemMint
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    func refreshWeather() {
        weatherManager.fetchWeather(latitude: 40.7128, longitude: -74.0060) { weatherArray in
            DispatchQueue.main.async {
                self.weatherData = weatherArray
            }
        }
    }
}

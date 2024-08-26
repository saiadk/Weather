//
//  HomeHeaderView.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation
import SwiftUI
import URLImage

struct Header: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 36))
            .foregroundColor(.white)
            .fontWeight(.light)
    }
}

struct WeatherHeaderView: View {
    @EnvironmentObject var screenViewModel: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            let weather = screenViewModel.weather
            Text(screenViewModel.weather?.name ?? "--")
                .modifier(Header())
                .shadow(radius: 10)

            HStack {
                Text((weather?.main?.temp != nil ? (String(Int(weather?.main?.temp ?? 0)) + "°") : "--"))
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .shadow(radius: 10)
            }
            
            HStack {
                Text((weather?.weather?.first?.main?.capitalized ?? weather?.weather?.first?.description?.capitalized) ?? "--")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .shadow(radius: 10)

                URLImage(URL(string: screenViewModel.getImageURL(imageName: (self.screenViewModel.weather?.weather?.first?.icon ?? "")))!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                        .shadow(radius: 5)

                }
            }
            
            let min = weather?.main?.temp_min ?? 0
            let max = weather?.main?.temp_max ?? 0

            Text("H:\(Int(max))° L:\(Int(min))°")
                .font(.system(size: 18, weight: .light, design: .default))
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.top, 5)
        }
    }
}

//
//  HoursForecastView.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation
import SwiftUI
import URLImage

struct HoursForecastView: View {
    
    @EnvironmentObject var screenViewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.black)
                    .opacity(0.23)
            VStack(alignment: .leading) {
                Text("HOURLY FORECAST")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .light, design: .default))
                    .multilineTextAlignment(.leading)
                    .padding([.top,.leading], 10)
                    
                Divider()
                    .background(.white)
                
                ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 16) {
                            ForEach(Array(zip(screenViewModel.hourDetails.indices, screenViewModel.hourDetails)), id: \.1.dt) { index, item in
                                VStack {
                                    if index != 0 {
                                        Text("\(screenViewModel.getHourFromTimestamp(timeStamp: item.dt ?? 0))")
                                            .font(.system(size: 15, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                            .padding(.top, 10)
                                    } else {
                                        Text("Now")
                                            .font(.system(size: 15, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                            .padding(.top, 10)
                                    }
                                    
                                    URLImage(URL(string: screenViewModel.getImageURL(imageName: item.weather?.first?.icon ?? "" ))!) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                    }
                                    Text("\(Int(item.temp ?? 0))")
                                        .font(.system(size: 15, weight: .medium, design: .default))
                                        .foregroundColor(.white)
                                        .padding(.bottom, 10)
                                    Spacer()
                                }
                            }
                        }
                }
                .padding([.leading, .trailing], 20)
            }
        }
    }
}

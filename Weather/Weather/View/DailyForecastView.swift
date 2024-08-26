//
//  DailyForecastView.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation
import SwiftUI
import URLImage

struct DailyForecastView: View {
    
    @EnvironmentObject var screenViewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.black)
                .opacity(0.23)

            VStack(alignment: .leading) {
                Text("8-DAY FORECAST")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .light, design: .default))
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .padding([.leading,.bottom], 10)
                
                Divider()
                    .background(.white)
                    
                
                VStack(alignment: .leading) {
                    ForEach(Array(zip(screenViewModel.dailyDetails.indices, screenViewModel.dailyDetails)), id: \.1.dt) { index, item in
                        HStack {
                            VStack(alignment: .leading) {
                                if index != 0 {
                                    Text("\(screenViewModel.getDayNameFromTimeStamp(timeStamp: item.dt ?? 0))")
                                        .font(.system(size: 20, weight: .medium, design: .default))
                                        .foregroundColor(.white)
                                        .padding(.top, 10)
                                } else {
                                    Text("Today")
                                        .font(.system(size: 20, weight: .medium, design: .default))
                                        .foregroundColor(.white)
                                        .padding(.top, 10)
                                }
                            }
                            .frame(width: 70, alignment: .leading)
                            Spacer()
                            
                            URLImage(URL(string: screenViewModel.getImageURL(imageName: item.weather?.first?.icon ?? "" ))!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                            }
                            Spacer()
                            HStack {
                                Text("\(Int(screenViewModel.getMinMaxTemperature(item: item).0))°")
                                    .font(.system(size: 18, weight: .medium, design: .default))
                                    .foregroundColor(.cyan)
                                    .padding(.top, 10)
                                
                                Capsule()
                                    .fill(LinearGradient(
                                        gradient: .init(colors: [.yellow, .orange, .orange]),
                                        startPoint: .init(x: 0.2, y: 0),
                                        endPoint: .init(x: 0.8, y: 0)
                                    ))
                                    .frame(width: 90, height: 5)
                                    .padding(.top, 10)
                                
                                Text("\(Int(screenViewModel.getMinMaxTemperature(item: item).1))°")
                                    .font(.system(size: 18, weight: .medium, design: .default))
                                    .foregroundColor(.white)
                                    .padding(.top, 10)

                            }

                        }
                        
                        if index < screenViewModel.dailyDetails.count-1 {
                            Divider()
                                .background(.white)
                        } else {
                            Spacer()
                                .padding(.bottom, 10)
                        }
                    }
                }
                .padding([.leading, .trailing], 20)
            }
        }
    }
}

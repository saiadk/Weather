//
//  HomeSearchView.swift
//  Weather
//
//  Created by Sai Mangaraju on 8/23/24.
//

import Foundation
import SwiftUI

struct WeatherSearchView: View {
    @Binding var isShowingLocation: Bool
    @EnvironmentObject var screenViewModel: WeatherViewModel

    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                isShowingLocation = true
            }) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
            }.padding(.trailing, 20)
        }
    }
}

//
//  AboutView.swift
//  Beautiful Things
//
//  A simple about view with external links that opens Safari.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        @Environment(\.openURL) var openURL
        
        VStack {
            VStack(spacing: 20) {
                Image("AF")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
                Text("Aura Fashion")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            Text("Aura Fashion brings you the finest collection of 3D sunglasses.\nExplore, try on, and fall in love with fashion.\n")
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 0) {
                Text("Made with Love by ")
                    .fontWeight(.regular)
                
                Link("Matthew Hoerl", destination: URL(string: "https://twitter.com/MattHoerl")!)
                    .foregroundColor(.white)
            }
            
            HStack(spacing: 0) {
                Text("App developed by ")
                    .fontWeight(.regular)
                
                Link("Augmenos", destination: URL(string: "https://www.augmenos.com")!)
                    .foregroundColor(.white)
            }

            Button {
                print("Button: Feedback")
                openURL(URL(string: "https://beautifulthings.xyz/feedback")!)
            } label: {
                Image(systemName: "heart.rectangle")
                    .padding(.trailing, 3)
                Text("Send us feedback")
            }
            .padding(.vertical, 25)
            
            Text("This app showcases premium sunglasses collections in AR\nfor fashion enthusiasts and style explorers.\nWe hope this app inspires your next fashion choice.")
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
        }
        .padding(40)
    }
    
}

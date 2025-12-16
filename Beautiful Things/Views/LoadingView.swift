//
//  LoadingView.swift
//  Beautiful Things
//
//  An additional loading view if loading large sets of data, now with animated aura and greetings.
//

import SwiftUI

struct LoadingView: View {
    @State private var animateAura = false

    private let greetings = [
        "Hello",         // English
        "Hola",          // Spanish
        "Bonjour",       // French
        "Ciao",          // Italian
        "Hallo",         // German
        "こんにちは",        // Japanese
        "안녕하세요",         // Korean
        "你好",            // Chinese (Mandarin)
        "Здравствуйте",   // Russian
        "مرحبا",           // Arabic
        "Olá",           // Portuguese
        "नमस्ते"           // Hindi
    ]
    @State private var currentGreetingIndex = 0
    @State private var flip = false

    // Timer to flip greeting every 1.3s
    private let greetingInterval: TimeInterval = 1.3

    var body: some View {
        ZStack {
            // More opaque Aura effect: three pulsing circles with higher opacity
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.purple.opacity(0.6), .blue.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 280, height: 280)
                    .scaleEffect(animateAura ? 1.2 : 0.9)
                    .opacity(animateAura ? 0.5 : 0.33)
                    .blur(radius: 32)
                    .animation(.easeInOut(duration: 2.1).repeatForever(autoreverses: true), value: animateAura)
                Circle()
                    .fill(LinearGradient(colors: [.pink.opacity(0.33), .mint.opacity(0.3)], startPoint: .bottomLeading, endPoint: .topTrailing))
                    .frame(width: 170, height: 170)
                    .offset(x: -60, y: 60)
                    .scaleEffect(animateAura ? 1.14 : 0.92)
                    .opacity(animateAura ? 0.36 : 0.22)
                    .blur(radius: 26)
                    .animation(.easeInOut(duration: 1.7).repeatForever(autoreverses: true).delay(0.7), value: animateAura)
                Circle()
                    .fill(LinearGradient(colors: [.yellow.opacity(0.18), .orange.opacity(0.22)], startPoint: .topTrailing, endPoint: .bottom))
                    .frame(width: 210, height: 210)
                    .offset(x: 70, y: -50)
                    .scaleEffect(animateAura ? 1.08 : 0.96)
                    .opacity(animateAura ? 0.26 : 0.15)
                    .blur(radius: 21)
                    .animation(.easeInOut(duration: 2.6).repeatForever(autoreverses: true).delay(0.3), value: animateAura)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .allowsHitTesting(false)

            VStack(spacing: 40) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2.2)
                    .shadow(color: .white.opacity(0.3), radius: 15, x: 0, y: 4)

                // Flipping "Hello" in different languages
                ZStack {
                    ForEach(greetings.indices, id: \.self) { idx in
                        if idx == currentGreetingIndex {
                            Text(greetings[idx])
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundStyle(LinearGradient(colors: [.pink, .purple, .blue], startPoint: .leading, endPoint: .trailing))
                                .rotation3DEffect(
                                    .degrees(flip ? 180 : 0),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .opacity(flip ? 0.0 : 1.0)
                                .animation(.easeInOut(duration: 0.55), value: flip)
                                .id(idx)
                        }
                    }
                }
                .frame(height: 50)
                .padding(.top, 10)

                // Still show the loading text, slightly faded so the greeting stands out
                Text("Loading Aura Fashion Collection")
                    .font(.title3)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(LinearGradient(colors: [.pink, .purple, .blue], startPoint: .leading, endPoint: .trailing))
                    .opacity(0.68)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .background(Color(.systemBackground))
        .onAppear {
            animateAura = true

            // Timer for flipping greetings
            Timer.scheduledTimer(withTimeInterval: greetingInterval, repeats: true) { timer in
                withAnimation(.easeInOut(duration: 0.55)) {
                    flip = true
                }
                // After animation, update index and flip back
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                    currentGreetingIndex = (currentGreetingIndex + 1) % greetings.count
                    flip = false
                }
            }
        }
    }
}

//
//  ContentView.swift
//  HeartAnimation
//
//  Created by koala panda on 2024/09/13.
//

import SwiftUI

struct ContentView: View {
    @State private var heartAnimations = [UUID]()

    var body: some View {
        ZStack {
            // タップ可能なハートボタン
            Button(action: {
                addHeartAnimation()
            }) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 50, height: 50)
            }

            // ハートのアニメーション
            ForEach(heartAnimations, id: \.self) { id in
                HeartAnimationView {
                    // アニメーションが終わったらUUIDを削除
                    removeHeartAnimation(id: id)
                }
            }
        }
    }

    func addHeartAnimation() {
        heartAnimations.append(UUID())
    }

    func removeHeartAnimation(id: UUID) {
        if let index = heartAnimations.firstIndex(of: id) {
            heartAnimations.remove(at: index)
        }
    }
}

struct HeartAnimationView: View {
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0
    @State private var opacity: Double = 1
    @State private var scale: CGFloat = 1
    @State private var rotation: Double = 0
    @State private var size: CGFloat = CGFloat.random(in: 20...40)
    @State private var color: Color = [.yellow, .pink, .orange].randomElement()!

    var onAnimationEnd: () -> Void

    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .foregroundColor(color)
            .frame(width: size, height: size)
            .offset(x: xOffset, y: yOffset)
            .opacity(opacity)
            .scaleEffect(scale)
            .rotationEffect(Angle(degrees: rotation))
            .onAppear {
                startAnimation()
            }
            .onDisappear {
                onAnimationEnd()
            }
    }

    func startAnimation() {
        let animationDuration: Double = 2
        xOffset = CGFloat.random(in: -100...100)
        withAnimation(.easeOut(duration: animationDuration)) {
            yOffset = -300
            opacity = 0
            scale = 1.5
            rotation = Double.random(in: -45...45)
        }
    }
}


#Preview {
    ContentView()
}

//
//  ContentView.swift
//  CountDown
//
//  Created by Algun Romper on 1/5/24.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var progressCount: Int = 30
    @State private var timerFinished = false
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: 230, height: 230)
                .shadow(color: .gray.opacity(0.3), radius: 7.5, x: 0, y: 5)
            
            Circle()
                .stroke(circleColor, lineWidth: 20)
                .frame(width: 180, height: 180)
                .shadow(color: .gray.opacity(0.2), radius: 2.5, x: 0, y: 5)
            
            Circle()
                .trim(from: 0, to: CGFloat(progressCount) / 30)
                .stroke(strokeColor, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .frame(width: 180, height: 180)
                .rotationEffect(Angle(degrees: -90))
            
            ForEach(0..<20, id: \.self) { tick in
                Rectangle()
                    .fill(circleColor)
                    .frame(width: 3, height: 10)
                    .offset(y: (160 / 2) - 10)
                    .rotationEffect(.degrees(Double(tick) * 18))
            }
        }
        .overlay {
            VStack(spacing: 0) {
                RollingText(value: $progressCount)
            }
        }
        .onDisappear {
            timer.upstream.connect().cancel()
            timerFinished = true
        }
        .onReceive(timer) { _ in
            if progressCount > 0 {
                progressCount -= 1
            } else {
                timer.upstream.connect().cancel()
                timerFinished = true
            }
        }
    }
}

#Preview {
    ContentView()
}

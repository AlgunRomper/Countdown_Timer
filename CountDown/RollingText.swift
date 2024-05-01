//
//  RollingText.swift
//  CountDown
//
//  Created by Algun Romper on 1/5/24.
//

import SwiftUI

struct RollingText: View {
    @Binding var value: Int
    @State private var previousValue: Int = 0
    @State private var tensOffset: CGFloat = 0
    @State private var unitsOffset: CGFloat = 0
    
    @State private var displayedTens: Character = "0"
    @State private var displayedUnits: Character = "0"
    
    var tens: Character {
        "\(value)".first!
    }
    var units: Character {
        "\(value)".last!
    }
    var body: some View {
        HStack(spacing: 0) {
            if "\(value)".count == 2 {
                Text("8")
                    .font(.system(size: 76, weight: .bold, design: .default))
                    .opacity(0)
                    .overlay {
                        Text("\(displayedTens)")
                            .offset(y: tensOffset)
                    }
            }
            Text("8")
                .font(.system(size: 76, weight: .bold, design: .default))
                .opacity(0)
                .overlay {
                    Text("\(displayedUnits)")
                        .offset(y: unitsOffset)
                }
        }
        .padding(.vertical, -15)
        .clipped()
        .font(.system(size: 76, weight: .bold, design: .default))
        .foregroundColor(blueColor)
        .onAppear {
            updateDisplayedCharacters()
        }
        .onChange(of: value) { newValue in
            if "\(newValue)".last != "\(previousValue)".last {
                withAnimation(.easeInOut(duration: 0.25)) {
                    unitsOffset = 80
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    updateDisplayedCharacters()
                    unitsOffset = -80
                    withAnimation(.easeInOut(duration: 0.5)) {
                        unitsOffset = 0
                    }
                }
            }
            if "\(newValue)".first != "\(previousValue)".first {
                withAnimation(.easeInOut(duration: 0.25)) {
                    tensOffset = 80
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    updateDisplayedCharacters()
                    tensOffset = -80
                    withAnimation(.easeInOut(duration: 0.5)) {
                        tensOffset = 0
                    }
                }
            }
            previousValue = newValue
        }
    }
    
    private func updateDisplayedCharacters() {
        displayedTens = "\(value)".count == 2 ? "\(value)".first! : "0"
        displayedUnits = "\(value)".last!
    }
}

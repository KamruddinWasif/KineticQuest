// Obstacle.swift
import SwiftUI

struct Obstacle: View {
    var body: some View {
        Rectangle()
            .fill(Color.green)
            .frame(width: 100, height: 50)
            .overlay(
                Rectangle()
                    .stroke(Color.white, lineWidth: 3)
            )
    }
}

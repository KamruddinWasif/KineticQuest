// GameObject.swift
import SwiftUI

struct GameObject: View {
    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: 50, height: 50)
    }
}

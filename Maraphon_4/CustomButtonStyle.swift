//
//  CustomButtonStyle.swift
//  Maraphon_4
//
//  Created by Evgeny Evtushenko on 10/12/2023.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    private static let animationTime: TimeInterval = 0.22
    private let incresedSize = CGSize(width: 3.0, height: 3.0)
    private let decresedSize = CGSize(width: 0.86, height: 0.86)
    private let fullSize = CGSize(width: 1, height: 1)
    private let linearAnimation = Animation.linear(duration: Self.animationTime)
    @State private var showAnimation: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background {
                Circle()
                    .foregroundStyle(Color(white: 0.9))
                    .opacity(showAnimation ? 1.0 : 0.0)
                    .scaleEffect(incresedSize, anchor: .center)
            }
        .onChange(of: configuration.isPressed, { oldValue, newValue in
            showAnimation = true
            
            DispatchQueue.main.asyncAfter(
                deadline: .now() + Self.animationTime
            ) {
                showAnimation = false
            }
        })
        .scaleEffect(showAnimation ? decresedSize : fullSize)
        .opacity(configuration.isPressed ? 0.8 : 1.0)
        .animation(linearAnimation, value: showAnimation)
    }
}

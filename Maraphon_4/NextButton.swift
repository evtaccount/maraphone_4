//
//  NextButton.swift
//  Maraphon_4
//
//  Created by Evgeny Evtushenko on 10/12/2023.
//

import SwiftUI

struct NextButton: View {
    let action: () -> Void
    
    private let buttonSize: CGFloat = 50
    private var iconSize: CGFloat { buttonSize / 2 }
    private static let animationTime: TimeInterval = 0.44
    private let fullSize = CGSize(width: 1, height: 1)
    private let springAnimation = Animation.spring(.bouncy(duration: animationTime, extraBounce: 0.15))
    
    @State private var showAnimation: Bool = false
    
    var body: some View {
        Button(action: {
            showAnimation = true
            
            DispatchQueue.main.asyncAfter(
                deadline: .now() + Self.animationTime
            ) {
                showAnimation = false
            }
            
            action()
        }, label: {
            let halfToLeft = CGSize(width: -iconSize / 2, height: 0.0)
            let halfToRight = CGSize(width: iconSize / 2, height: 0.0)
            
            HStack(spacing: 0) {
                arrow
                    .frame(width: iconSize, height: iconSize)
                    .opacity(showAnimation ? 1 : 0)
                    .scaleEffect(showAnimation ? fullSize : .zero)
                    .offset(showAnimation ? halfToRight : .zero)
                arrow
                    .frame(width: iconSize, height: iconSize)
                    .offset(showAnimation ? halfToRight : halfToLeft)
                arrow
                    .frame(width: iconSize, height: iconSize)
                    .opacity(showAnimation ? 0.0 : 1)
                    .scaleEffect(showAnimation ? .zero : fullSize)
                    .offset(showAnimation ? halfToRight : halfToLeft)
            }
            .foregroundStyle(.black)
            .animation(showAnimation ? springAnimation : nil, value: showAnimation)
        })
        .frame(width: buttonSize, height: buttonSize)
        .buttonStyle(CustomButtonStyle())
    }
    
    private var arrow: some View {
        Image(systemName: "play.fill")
            .resizable()
    }
}

#Preview {
    NextButton(action: {})
}

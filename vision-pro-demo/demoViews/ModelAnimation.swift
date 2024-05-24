//
//  ImmersiveView.swift
//  vision-pro-demo
//
//  Created by Yuhang on 2024/5/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ModelAnimation: View {
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "dance", in: realityKitContentBundle) {
                content.add(scene)
                for anim in scene.availableAnimations {
                    scene.playAnimation(anim.repeat(duration: .infinity), transitionDuration: 1.25, startsPaused: false)
                }
            }
                
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ModelAnimation()
}

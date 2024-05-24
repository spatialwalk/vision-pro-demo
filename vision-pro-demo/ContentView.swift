//
//  ContentView.swift
//  vision-pro-demo
//
//  Created by Yuhang on 2024/5/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var enlarge = false
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @State private var currentImmersiveSpaceId: String = ""

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                content.add(scene)
            }
        } update: { content in
            // Update the RealityKit content when SwiftUI state changes
            if let scene = content.entities.first {
                let uniformScale: Float = enlarge ? 1.4 : 1.0
                scene.transform.scale = [uniformScale, uniformScale, uniformScale]
            }
        }
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: currentImmersiveSpaceId) {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                        currentImmersiveSpaceId = ""
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                    currentImmersiveSpaceId = ""
                }
            }
        }
        .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
            enlarge.toggle()
        })
        .toolbar {
            ToolbarItemGroup(placement: .bottomOrnament) {
                VStack (spacing: 12) {
                    Toggle("Enlarge RealityView Content", isOn: $enlarge)
                    Toggle(isOn: $showImmersiveSpace) {
                        if showImmersiveSpace {
                            Text(currentImmersiveSpaceId)
                        } else {
                            Text("none")
                        }
                        
                    }
                    Button("Open ModelAnimation") {
                        showImmersiveSpace = true
                        currentImmersiveSpaceId = "ModelAnimation"
                    }
                    
                }
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}

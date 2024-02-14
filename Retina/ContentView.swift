//
//  ContentView.swift
//  Retina
//
//  Created by Asher Pope on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var R = 193.0
    @State private var r = 48.0
    @State private var d = 9.0
    @State private var amount = 0.30
    
    @State private var scale = 1.0
    @State private var zoom = 0.0
    
    var totalScale: Double {
        scale + zoom
    }
    
    @State private var xRotation = 1.0
    @State private var xRotationModifier = 0.001
    
    @State private var yRotation = 1.0
    @State private var yRotationModifier = 0.001
    
    @State private var allRotation = 0.0
    @State private var sleepMode = false
    @State private var animate = false
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    func generateRandomRetina() {
        R = Double.random(in: 0...256)
        r = Double.random(in: 0...256)
        d = Double.random(in: 0...256)
        amount = Double.random(in: 0.1...1)
        xRotation = Double.random(in: -1...1)
        yRotation = Double.random(in: -1...1)
        allRotation = Double.random(in: 0...360)
        
    }
    
    var body: some View {
        ZStack {
            if !sleepMode {
                Color.white
                    .ignoresSafeArea()
                    .onTapGesture(count: 2) {
                        withAnimation {
                            sleepMode.toggle()
                        }
                    }
            } else {
                Color.black
                    .ignoresSafeArea()
                    .onTapGesture(count: 2) {
                        withAnimation {
                            sleepMode.toggle()
                        }
                    }
            }
            
            ZStack {
                Hypotrochoid(R: Int(R), r: Int(r), d: Int(d), amount: amount, scale: totalScale, xRotation: xRotation, yRotation: yRotation)
                    .stroke(sleepMode ? .white : .black, lineWidth: 0.5)
                    .rotationEffect(Angle(degrees: allRotation * 1.25), anchor: .center)
                
                Epitrochoid(R: Int(R), r: Int(r), d: Int(d), amount: amount, scale: totalScale, xRotation: xRotation, yRotation: yRotation)
                    .stroke(sleepMode ? .white : .black, lineWidth: 0.5)
                    .rotationEffect(Angle(degrees: allRotation * 0.5), anchor: .center)
                
                Hypocycloid(R: Int(R), r: Int(r), amount: amount, scale: totalScale, xRotation: xRotation, yRotation: yRotation)
                    .stroke(sleepMode ? .white : .black, lineWidth: 0.5)
                    .rotationEffect(Angle(degrees: allRotation * 0.25), anchor: .center)
            }
            .drawingGroup()
            .onReceive(timer) { _ in
                if animate { incrementAmount() }
            }
            .ignoresSafeArea()
            .zIndex(1)
            .contentShape(Circle())
            .gesture(
                MagnifyGesture()
                    .onChanged { value in
                        zoom = value.magnification - 1
                    }
                    .onEnded { value in
                        scale += zoom
                        zoom = 0
                    }
            )
            .onTapGesture {
                withAnimation {
                    animate.toggle()
                }
            }
            
            
            
            
            VStack {
                Spacer()
                HStack {
                    Menu("\(Image(systemName: "menucard"))") {
                        Button("Generate") {
                            generateRandomRetina()
                        }
                        
                        
                        Button("Flip X") {
                            if xRotationModifier.isEqual(to: 0.001) {
                                xRotationModifier = -0.001
                            } else {
                                xRotationModifier = 0.001
                            }
                        }
                        
                        
                        Button("Flip Y") {
                            if yRotationModifier.isEqual(to: 0.001) {
                                yRotationModifier = -0.001
                            } else {
                                yRotationModifier = 0.001
                            }
                        }
                        
                        
                        Button("Reanimate") {
                            self.amount = 0
                            if amount <= 1 { amount = 0 }
                        }
                        
                        Button("Invert") {
                            withAnimation {
                                sleepMode.toggle()
                            }
                        }
                        
                        
                        Button("Reset scale") {
                            withAnimation {
                                scale = 1.0
                                zoom = 0
                            }
                        }
                        
                    }
                    .zIndex(3)
                    .buttonStyle(.bordered)
                    .tint(sleepMode ? .white : .black)
                    
                    Spacer()
                    
                }
                .zIndex(3)
                .padding(.leading, 30)
            }
            .zIndex(3)
            .padding(.bottom)
            
            
            VStack {
//                Spacer()
//                HStack {
//                    
//                    
//                }
//                .padding(.horizontal)
//                .zIndex(2)
//                .onTapGesture {
//                    print("tapped menu")
//                }
                
                
                //Spacer()
                
                // Old loc of retina stack
                
                //                Spacer()
                //
                //                Group {
                //
                //                    Text("R: \(Int(R))")
                //                    Slider(value: $R, in: 0...256, step: 1)
                //                        .padding([.horizontal, .bottom])
                //
                //                    Text("r: \(Int(r))")
                //                    Slider(value: $r, in: 0...256, step: 1)
                //                        .padding([.horizontal, .bottom])
                //
                //                    HStack {
                //                        VStack {
                //                            Text("d: \(Int(d))")
                //                            Slider(value: $d, in: 0...256, step: 1)
                //                        }
                //
                //                        VStack {
                //                            Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
                //                            Slider(value: $amount)
                //                        }
                //                    }.padding([.horizontal, .bottom])
                //                }
                //                Group {
                //                    HStack {
                //                        VStack {
                //                            Text("Scale: \(scale, format: .number.precision(.fractionLength(2)))")
                //                            Slider(value: $scale, in: 0.01...5)
                //                        }
                //
                //                        VStack {
                //                            Text("Rotation X: \(xRotation, format: .number.precision(.fractionLength(2)))")
                //                            Slider(value: $xRotation, in: -1...1)
                //                        }
                //
                //                        VStack {
                //                            Text("Rotation Y: \(yRotation, format: .number.precision(.fractionLength(2)))")
                //                            Slider(value: $yRotation, in: -1...1)
                //                        }
                //                    }.padding([.horizontal, .bottom])
                //
                //                    Text("Rotation All: \(allRotation, format: .number.precision(.fractionLength(2)))")
                //                    Slider(value: $allRotation, in: 0...360)
                //                        .padding([.horizontal, .bottom])
                //                }
            }
        }
    }
    
    func incrementAmount() {
        withAnimation {
            if amount < 0.999 {
                self.amount += 0.001
            } else {
                amount -= 0.001
            }
            
            self.xRotation += xRotationModifier
            self.yRotation += yRotationModifier
            
        }
    }
}


#Preview {
    ContentView()
}

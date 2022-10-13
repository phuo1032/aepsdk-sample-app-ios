//
//  InnovationLiveActivity.swift
//  Innovation
//
//  Created by phuo on 10/10/22.
//  Copyright © 2022 Christopher Hoffman. All rights reserved.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct InnovationLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: InnovationAttributes.self) { context in
            // Create the view that appears on the Lock Screen and as a
            // banner on the Home Screen of devices that don't support the
            // Dynamic Island.
            LockScreenLiveActivityView(context: context)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Create the expanded view.
                DynamicIslandExpandedRegion(.leading) {
                    Label("\(context.state.driverName)", systemImage: "1.circle")
                        .font(.title2)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text("\(Int(context.state.currentLap))/\(Int(context.attributes.totalLap))")
                            .multilineTextAlignment(.trailing)
                            .frame(width: 50)
                            .monospacedDigit()
                    } icon: {
                        Image(systemName: "flag.checkered")
                    }
                    .font(.title2)
                }
                
                DynamicIslandExpandedRegion(.center) {
                    Text("\(context.state.driverName) is first!")
                        .lineLimit(1)
                        .font(.headline)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
//                    Button {
//                        // Deep link into your app.
//                    } label: {
//                        Label("Call driver", systemImage: "phone")
//                    }
//                    .foregroundColor(.indigo)
                }
            } compactLeading: {
                Label {
                    Text("\(context.state.driverName)")
                } icon: {
                    Image(systemName: "1.circle")
                        .foregroundColor(.red)
                }
                .font(.caption2)
            } compactTrailing: {
                Label {
                    Text("\(Int(context.state.currentLap))/\(Int(context.attributes.totalLap))")
                        .multilineTextAlignment(.center)
                        .frame(width: 40)
                        .font(.caption2)
                } icon: {
                    Image(systemName: "flag.checkered")
                }
            } minimal: {
                VStack(alignment: .center) {
                    Label("\(context.state.driverName)", systemImage: "1.circle")
                        .font(.title2)
                }
            }
            .keylineTint(.cyan)
        }
    }
}


struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<InnovationAttributes>

    var body: some View {

        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .center) {
                    if (context.state.currentLap > context.attributes.totalLap) {
                        Text("Race Complete").font(.headline)
                        Spacer()
                        Text(context.state.driverName + " won!!!").font(.headline)
                    } else {
                        Text("Race Started!").font(.headline)
                        Spacer()
                        ProgressView("Current Lap: \(Int(context.state.currentLap))/\(Int(context.attributes.totalLap))", value: context.state.currentLap, total: context.attributes.totalLap).font(.subheadline)
                        Spacer()
                        Text(context.state.driverName + " is currently first!").font(.headline)

                    }
                }
            }
        }.padding(15)
    }
}

struct BottomLineView: View {
    var time: Double
    var body: some View {
        HStack {
            Divider().frame(width: 50,
                            height: 10)
            .overlay(.gray).cornerRadius(5)
            Image("delivery")
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(style: StrokeStyle(lineWidth: 1,
                                               dash: [4]))
                    .frame(height: 10)
                    .overlay(Text(Date().addingTimeInterval(time), style: .timer).font(.system(size: 8)).multilineTextAlignment(.center))
            }
            Image("home-address")
        }
    }
}

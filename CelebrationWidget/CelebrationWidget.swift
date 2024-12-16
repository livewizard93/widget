//
//  CelebrationWidget.swift
//  CelebrationWidget
//
//  Created by dev on 12/15/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), note: "😀 Matin - birthday\r\n😀 Sarah - name day")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), note: "😀 Matin - birthday\r\n😀 Sarah - name day")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, note: "😀 Matin - birthday\r\n😀 Sarah - name day")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let note: String
}

struct CelebrationWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .center, spacing: nil) {
            Text("Today's celebrations")
                .font(.system(size: 12))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.bottom, 7)
            Text(entry.note)
                .font(.system(size: 14))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(
            Image("background")
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
        )
    }
}

struct CelebrationWidget: Widget {
    let kind: String = "CelebrationWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                CelebrationWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                CelebrationWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("celebration Widget")
        .description("This is an celebration widget.")
        .supportedFamilies([.systemMedium])
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    CelebrationWidget()
} timeline: {
    SimpleEntry(date: .now, note: "😀 Matin - birthday\r\n\r\n😀 Sarah - name day")
}

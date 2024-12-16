//
//  CelebrationWidget.swift
//  CelebrationWidget
//
//  Created by dev on 12/15/24.
//

import WidgetKit
import SwiftUI


struct Provider: TimelineProvider {
    let helper = DBHelper()
    
    func placeholder(in context: Context) -> SimpleEntry {
        let now = Date()
        let (note, photo) = helper.readTodayData(date: now)
        return SimpleEntry(
            date: now,
            note: note,
            photoURL: photo
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let now = Date()
        let (note, photo) = helper.readTodayData(date: now)
        let entry = SimpleEntry(
            date: Date(),
            note: note,
            photoURL: photo
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let (note, photo) = helper.readTodayData(date: entryDate)
            let entry = SimpleEntry(
                date: entryDate,
                note: note,
                photoURL: photo
            )
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let note: String
    let photoURL: String
}

struct CelebrationWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .center, spacing: nil) {
            Text("Today's celebrations")
                .font(.system(size: 14))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .shadow(
                    color: Color.primary.opacity(0.3),
                    radius: 3,
                    x: 0,
                    y: 2
                )
                .padding(.bottom, 7)
            Text(entry.note)
                .font(.system(size: 15))
                .foregroundStyle(.white)
                .lineSpacing(5.0)
                .shadow(
                    color: Color.primary.opacity(0.3),
                    radius: 3,
                    x: 0,
                    y: 2
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(
            Group {
                if let url = URL(string: entry.photoURL), let imageData = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: imageData) {

                    Image(uiImage: uiImage)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                }
                else {
                    Image("background")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                }
            }
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
    let helper = DBHelper()
    let now = Date()
    let (note, photo) = helper.readTodayData(date: now)
    
    SimpleEntry(
        date: .now,
        note: note,
        photoURL: photo
    )
}



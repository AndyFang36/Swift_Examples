//
//  main.swift
//  C18_Concurrency: Perform asynchronous operations.
//
//  Created by Andy Fang on 28/01/2024.
//

import Foundation

/** Defining and Calling Asynchronous Functions */
func listPhotos(inGallery name: String) async -> [String] {
    print("handling...")
    // try await Task.sleep(for: .seconds(2))
    return ["IMG001", "IMG99", "IMG0404"]
}

func downloadPhoto(named: String) async throws -> String {
    print("downloading...")
    try await Task.sleep(for: .seconds(3))
    return "This is \(named)"
}

let photoNames =  await listPhotos(inGallery: "Summer")
let sortedNames = photoNames.sorted()
for name in sortedNames { print(name) }
let toDownload = try await downloadPhoto(named: sortedNames[0])
print(toDownload)
print("hello")

/** Asynchronous Sequences */
let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}


/** Calling Asynchronous Functions in Parallel */
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])
let photos = try await [firstPhoto, secondPhoto, thirdPhoto]


/** Tasks and Task Groups */
//try await withTaskGroup(of: Data.self) { group in
//    let photoNames = await listPhotos(inGallery: "Summer")
//    for name in photoNames {
//        group.addTask() {
//            return await downloadPhoto(named: name)
//        }
//    }
//}


/** Actors */
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int
    
    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)

extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}



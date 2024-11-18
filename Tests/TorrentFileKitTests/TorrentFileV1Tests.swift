import Testing
@testable import TorrentFileKit
import Foundation
import BencodeKit

@Suite
struct TorrentFileV1Tests {
    static func url(named name: String, ext: String) -> URL? {
        if let u = Bundle.module.url(forResource: name, withExtension: ext) {
            // SPM
            return u
        }
        if let u = Bundle.module.url(forResource: "Resources/\(name)", withExtension: ext) {
            // Xcode
            return u
        }
        return nil
    }
    
    @Suite(.disabled())
    struct BitForBitIdenticalTests {
        // We actually only care about a bit-for-bit reproduction of the `info` dictionary inside the root dictionary,
        //   but it's a pain to extract that Data, so we just try to do the entire torrent.

        @Test
        func pureSingleFileV1DataToTorrentToData() async throws {
            let u = try #require(url(named: "v1.txt", ext: "torrent"))
            let data = try Data(contentsOf: u)

            let torrent = try BencodeDecoder().decode(TorrentFileV1.self, from: data)
            let newData = try BencodeEncoder().encode(torrent)

            #expect(newData == data)

            if newData != data {
                let dir = URL.currentDirectory().appending(path: #file).appending(path: #function)
                try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
                try data.write(to: dir.appending(path: "original.data"))
                try newData.write(to: dir.appending(path: "new.data"))
            }
        }
        @Test
        func pureMultipleFileV1DataToTorrentToData() async throws {
            let u = try #require(url(named: "dirv1", ext: "torrent"))
            let data = try Data(contentsOf: u)

            let torrent = try BencodeDecoder().decode(TorrentFileV1.self, from: data)
            let newData = try BencodeEncoder().encode(torrent)

            #expect(newData == data)

            if newData != data {
                let dir = URL.currentDirectory().appending(path: #file).appending(path: #function)
                try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
                try data.write(to: dir.appending(path: "original.data"))
                try newData.write(to: dir.appending(path: "new.data"))
            }
        }
    }

    @Suite
    struct InfoDictTests {
        @Suite
        struct BitForBitIdenticalTests {
            @Test
            func pureSingleFileV1DataToInfoDictToData() async throws {
                let u = try #require(url(named: "v1.txt", ext: "infodict"))
                let data = try Data(contentsOf: u)

                let torrent = try BencodeDecoder().decode(TorrentFileV1.InfoDictionary.self, from: data)
                let newData = try BencodeEncoder().encode(torrent)

                #expect(newData == data)

                if newData != data {
                    let dir = URL.currentDirectory().appending(path: #file).appending(path: #function)
                    try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
                    try data.write(to: dir.appending(path: "original.data"))
                    try newData.write(to: dir.appending(path: "new.data"))
                }
            }
            @Test
            func pureMultipleFileV1DataToTorrentToData() async throws {
                let u = try #require(url(named: "dirv1", ext: "infodict"))
                let data = try Data(contentsOf: u)

                let torrent = try BencodeDecoder().decode(TorrentFileV1.InfoDictionary.self, from: data)
                let newData = try BencodeEncoder().encode(torrent)

                #expect(newData == data)

                if newData != data {
                    let dir = URL.currentDirectory().appending(path: #file).appending(path: #function)
                    try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
                    try data.write(to: dir.appending(path: "original.data"))
                    try newData.write(to: dir.appending(path: "new.data"))
                }
            }
        }
    }
}

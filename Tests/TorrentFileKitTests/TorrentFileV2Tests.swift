import Testing
@testable import TorrentFileKit
import Foundation
import BencodeKit

@Suite
struct TorrentFileV2Tests {
    @Suite(.disabled())
    struct BitForBitIdenticalTests {
        @Test
        func pureSingleFileV2DataToTorrentToData() async throws {
            let u = try #require(Bundle.module.url(forResource: "v2.txt", withExtension: "torrent"))
            let data = try Data(contentsOf: u)

            let torrent = try BencodeDecoder().decode(TorrentFileV2.self, from: data)
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
        func pureMultipleFileV2DataToTorrentToData() async throws {
            let u = try #require(Bundle.module.url(forResource: "dirv2", withExtension: "torrent"))
            let data = try Data(contentsOf: u)

            let torrent = try BencodeDecoder().decode(TorrentFileV2.self, from: data)
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
        func pureSingleFileHybridDataToTorrentToData() async throws {
            let u = try #require(Bundle.module.url(forResource: "hybrid.txt", withExtension: "torrent"))
            let data = try Data(contentsOf: u)

            let torrent = try BencodeDecoder().decode(TorrentFileV2.self, from: data)
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
        func pureMultipleFileHybridDataToTorrentToData() async throws {
            let u = try #require(Bundle.module.url(forResource: "dirhybrid", withExtension: "torrent"))
            let data = try Data(contentsOf: u)

            let torrent = try BencodeDecoder().decode(TorrentFileV2.self, from: data)
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
            func pureSingleFileV2DataToTorrentToData() async throws {
                let u = try #require(Bundle.module.url(forResource: "v2.txt", withExtension: "infodict"))
                let data = try Data(contentsOf: u)

                let torrent = try BencodeDecoder().decode(TorrentFileV2.InfoDictionary.self, from: data)
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
            func pureMultipleFileV2DataToTorrentToData() async throws {
                let u = try #require(Bundle.module.url(forResource: "dirv2", withExtension: "infodict"))
                let data = try Data(contentsOf: u)

                let torrent = try BencodeDecoder().decode(TorrentFileV2.InfoDictionary.self, from: data)
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
            func pureSingleFileHybridDataToTorrentToData() async throws {
                let u = try #require(Bundle.module.url(forResource: "hybrid.txt", withExtension: "infodict"))
                let data = try Data(contentsOf: u)

                let torrent = try BencodeDecoder().decode(TorrentFileV2.InfoDictionary.self, from: data)
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
            func pureMultipleFileHybridDataToTorrentToData() async throws {
                let u = try #require(Bundle.module.url(forResource: "dirhybrid", withExtension: "infodict"))
                let data = try Data(contentsOf: u)

                let torrent = try BencodeDecoder().decode(TorrentFileV2.InfoDictionary.self, from: data)
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

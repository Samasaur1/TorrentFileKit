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
    
    @Suite
    struct BitForBitIdenticalTests {
        @Test
        func pureSingleFileV1DataToTorrentToData() async throws {
            let u = try #require(url(named: "v1.txt", ext: "torrent"))
            let data = try Data(contentsOf: u)

            let torrent = try BencodeDecoder().decode(TorrentFileV1.self, from: data)
            let newData = try BencodeEncoder().encode(torrent)

            #expect(newData == data)
        }
        @Test
        func pureMultipleFileV1DataToTorrentToData() async throws {
            let u = try #require(url(named: "dirv1", ext: "torrent"))
            let data = try Data(contentsOf: u)

            let torrent = try BencodeDecoder().decode(TorrentFileV1.self, from: data)
            let newData = try BencodeEncoder().encode(torrent)

            #expect(newData == data)
        }
    }
}

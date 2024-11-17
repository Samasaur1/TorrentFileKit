import Testing
@testable import TorrentFileKit
import Foundation
import BencodeKit

@Suite
struct TorrentFileV2Tests {
    @Test func example() async throws {
        let u = try #require(Bundle.module.url(forResource: "v2.txt", withExtension: "torrent"))
        let data = try Data(contentsOf: u)

        let torrent = try BencodeDecoder().decode(TorrentFileV2.self, from: data)
        let newData = try BencodeEncoder().encode(torrent)

        #expect(newData == data)
    }
}

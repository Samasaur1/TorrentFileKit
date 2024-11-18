import BencodeKit
import Foundation

public struct TorrentFile: Decodable {
    public init(from decoder: any Decoder) throws {
        switch try? VersionIdentifier(from: decoder).version {
        case 2:
            // torrent file v2
            self.init(fromV2: try TorrentFileV2(from: decoder))
        case nil:
            // No "meta version" key in torrent file; assume version 1 (all other versions should have a value)
            self.init(fromV1: try TorrentFileV1(from: decoder))
        default:
            // a torrent file version that we don't know
            let context = DecodingError.Context(codingPath: [], debugDescription: "Unknown meta version in torrent file!")
            throw DecodingError.dataCorrupted(context)
        }
    }

    init(fromV1 other: TorrentFileV1) {
    }

    init(fromV2 other: TorrentFileV2) {
    }
}

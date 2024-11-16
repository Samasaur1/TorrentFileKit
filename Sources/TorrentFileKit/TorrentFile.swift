import BencodeKit
import Foundation

public struct TorrentFile: Decodable {
    public init(from decoder: any Decoder) throws {
        if let v1 = try? TorrentFileV1(from: decoder) {
            self.init(fromV1: v1)
        } else if let v2 = try? TorrentFileV2(from: decoder) {
            self.init(fromV2: v2)
        } else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Cannot decode torrent file v1 or v2")
            throw DecodingError.dataCorrupted(context)
        }
    }

    init(fromV1 other: TorrentFileV1) {
    }

    init(fromV2 other: TorrentFileV2) {
    }
}

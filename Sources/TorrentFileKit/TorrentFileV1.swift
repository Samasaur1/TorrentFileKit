import BencodeKit
import Foundation

struct TorrentFileV1: Codable {
    struct InfoDictionary: Codable {
        struct MultipleFileInfo: Codable {
            let length: Int
            let path: [String]
        }

        let name: String
        let pieceLength: Int
        let pieces: Data

        let length: Int?
        let files: [MultipleFileInfo]?

        enum CodingKeys: String, CodingKey {
            case name
            case pieceLength = "piece length"
            case pieces
            case length
            case files
        }
    }

    let announce: String
    let info: InfoDictionary
}

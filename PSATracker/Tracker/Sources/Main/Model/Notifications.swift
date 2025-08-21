struct InAppNotification: Decodable {
    let id: String
    let title: String
    let message: String
    let imageUrl: String?
    let deepLink: String?
    let type: String   // e.g. "modal", "banner"
}
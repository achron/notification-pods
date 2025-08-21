import Foundation

class InAppNotificationAPI {
    static let shared = InAppNotificationAPI()
    private init() {}

    private let baseURL = "https://pndev.proemsportsanalytics.com/api/ccgt/inapp/campaign/"

    func fetchNotifications(completion: @escaping ([InAppNotification]?) -> Void) {
        let request = Request(
            url: baseURL,
            method: .get,
            headers: ["Content-Type": "application/json"],
            body: nil
        )

        DefaultNetworkConnection().send(request: request) { (result: RequestResult<Data>) in
            switch result {
            case .success(let data):
                do {
                    let notifications = try JSONDecoder().decode([InAppNotification].self, from: data)
                    completion(notifications)
                } catch {
                    print("JSON decode error: \(error)")
                    completion(nil)
                }
            case .failure(let error):
                print("Network error: \(error)")
                completion(nil)
            }
        }
    }
}

// TODO: Example of usage

/*
InAppNotificationAPI.shared.fetchNotifications { notifications in
    if let first = notifications?.first {
        InAppNotificationManager.shared.showNotification(first)
    }
}
*/
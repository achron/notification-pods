import Foundation
import UIKit

class InAppNotificationAPI {
    static let shared = InAppNotificationAPI()
    private init() {}

    private let baseURL = "https://pndev.proemsportsanalytics.com/api/ccgt/inapp/campaign/"

    func fetchNotifications(completion: @escaping ([InAppNotification]?) -> Void) {
        let request = Request(
            urlString: baseURL,                // ⚡️ urlString вместо url
            method: HttpMethodOptions.GET,     // ⚡️ .GET вместо .get
            headers: ["Content-Type": "application/json"],
            body: nil as Data?                 // ⚡️ явно указываем тип
        )

    // TODO: Fetch example
        // DefaultNetworkConnection().execute(request: request) { result in
        //     switch result {
        //     case .success(let data):
        //         do {
        //             let notifications = try JSONDecoder().decode([InAppNotification].self, from: data)
        //             completion(notifications)
        //         } catch {
        //             print("JSON decode error: \(error)")
        //             completion(nil)
        //         }
        //     case .failure(let error):
        //         print("Network error: \(error)")
        //         completion(nil)
        //     }
        // }
    }
}


class InAppNotificationManager {
    static let shared = InAppNotificationManager()
    private init() {}
    
    func showNotification(_ notification: InAppNotification) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: notification.title, message: notification.message, preferredStyle: .alert)
            if let deepLink = notification.deepLink {
                alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { _ in
                    if let url = URL(string: deepLink) {
                        UIApplication.shared.open(url)
                    }
                }))
            }
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
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
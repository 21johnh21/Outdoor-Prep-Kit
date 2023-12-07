//
//  CloudKit.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 12/6/23.
//

import Foundation
import CloudKit

struct CloudKitHelper {

    static func checkICloudAccountStatus(completion: @escaping (Bool) -> Void) {
        let container = CKContainer.default()

        container.accountStatus { (accountStatus, error) in
            DispatchQueue.main.async {
                switch accountStatus {
                case .available:
                    // The user is signed in to iCloud.
                    print("User is signed in to iCloud.")
                    completion(true)
                case .noAccount:
                    print("User is not signed in to iCloud.")
                    completion(false)
                case .restricted:
                    // iCloud is restricted on this device.
                    print("iCloud is restricted on this device.")
                    completion(false)
                case .couldNotDetermine:
                    // Unable to determine the iCloud account status.
                    print("Could not determine iCloud account status.")
                    completion(false)
                case .temporarilyUnavailable:
                    print("iCloud is temporarily unavailable")
                @unknown default:
                    fatalError("Unexpected case.")
                }
            }
        }
    }
}

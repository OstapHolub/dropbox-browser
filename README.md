# dropbox-browser
Media files browser from a shared folder.

## 🧐 Why?

Test project for interview. Quick and simple.

## ❗️ Before you begin

In order to compile project install:
- [SwiftGen](https://github.com/SwiftGen/SwiftGen#installation)
- [SwiftLint](https://github.com/realm/SwiftLint#using-homebrew)

## 🛠 Project Structure

### Config
Root folder for xcconfig files for release and debug configurations of the app. Each developer should have thier own config files called `config.debub` and `config.release` for Debub and Release configurations respectively. Structure is the same for both and looks like this:

```
CLIENT_ID = REPLACE WITH YOUR CLIENT ID
BASE_API_URL = REPLACE WITH YOUR BASE API URL
BASE_AUTH_URL = REPLAVE WITH YOUR BASE AUTH URL
```

### Flows
Folder contains files that are related to specific flow like auth, files browser, preview, file details, etc. Each individual flow contains root view, view model, specific to currecnt flow views, etc.

### Services
Space for shared services like keychain access, API client and so on. All services from the app should be stored here. Do not put them into specific flow folder.

### Resources
Contains assets catalogs for images, color, localizible files and autogenerated swift files for convenient access to them. Do not modify anything that has `generated` in file name.

### Extensions
Shared space for small type extensions providing convenient operations for common tasks.
 
### Views
Space for shared across multiple flows views. It's okay to move something from flow to this space whenever you need to use it for something else. Make sure that does not break anything before making such change.

### SupportingFiles
Auxiliary group to keep root directory clean. Contains info.plist.

## ✍️ Contributing

Interested in contributing to this demo project? Thanks so much for your interest! We are always looking for improvements to the project and contributions from open-source developers are greatly appreciated.

## ⚠️ License

Dropbox Browser are licensed under [MIT LICENSE](LICENSE). 

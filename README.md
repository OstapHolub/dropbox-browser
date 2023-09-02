# dropbox-browser
Media files browser from a shared folder

## Installation

## Project Structure

### Config
Root folder for xcconfig files for release and debug configurations of the app.

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

# Changelog

All notable changes to this project will be documented in this file.
For currently known issues, check the [GitHub issues tab](https://github.com/dhzdhd/ExCode/issues?q=is%3Aopen+is%3Aissue+label%3Abug)

## 1.1.0 | 25-02-2023

### Additions

- Added local file support which includes creating, renaming, writing to and deleting files (not available for web).
- Added a file and no file mode with no file mode being the default (Check the drawer to enable/disable it).

### Fixes / Improvements

- Improved text selection colors
- Improved errors
- Fixed snippet dialog size

## 1.0.0 | 22-01-2023

### Fixes / Improvements

- Fix CORS issues on custom pastebin
- Improve custom pastebin UI
- Some QOL improvements

## 0.5.1 | 17-01-2023

### Additions

- Added msix installer for Windows.

### Fixes / Improvements

- Migrate to custom pastebin implementation to avoid CORS issues.

## 0.5.0 | 06-01-2023

This will be the final major prerelease version. The following possible releases will be Release Candidate versions with bug fixes.

### Additions

- Added functionality to store snippets and settings on the cloud.
- Added a sync button to synchronise all the cloud settings with the local ones, overwriting the local settings.
- Added ability to highlight similar words (Right click selected text and select the `Match text` option in the editor).
- Moved the authentication options to a dropdown menu in the settings appbar.
- Added a confirm delete option to snippets.

### Fixes / Improvements

- Fixed issues with cursor color.
- Fixed and implemented an update option on Android.
- Fixed color inconsistencies in light mode.
- Fixed oversized Android icon.
- Reworked the snippet bar dialog UI.
- General QOL improvements.

## 0.4.1 | 30-11-2022 (HOTFIX)

### Additions

- Added functionality to create custom snippets.
- Added functionality to reorder snippet bar.

### Fixes / Improvements

- Fixed windows startup issue.
- Fixed issue where changing language crashed the editor.

## 0.4.0 | 28-11-2022

### Additions

- Add tab visibility setting and option to manually switch between tabs.
- Reintroduce save to cloud setting (does not work as for now).
- Add user accounts and login functionality.
- Add progress indicators to indicate execution progress.
- Add stdin and command line arguments.
- Add floating run button.

### Future additions

- Cloud storage of data
- Drag and open files on editor
- Add functionality to customise snippet bar.

### Fixes / Improvements

- Fix line number colors in light theme.
- Change font size button.
- Editor now switches to output tab on executing code.
- Line numbers should now update on changing language.

## 0.3.0 | 2-10-2022

### Additions

- Experimental linux and macos release.
- Add tab bar to switch between input and output.
- Check for internet connection and disallow editor usage if there is no connection.
- Add check for updates button on android.
- Add lock editor switch.
- Add hastebin functionality.
- Add error and success snackbars for features like hastebin and save.
- Add language version dialog
- Add app version in settings.
- Add dummy auth route and save to cloud switch.

### Fixes / Improvements

- Android release is now smaller in size.

### Known issues

- Tab does not switch to output on pressing run button.

## 0.2.0 | 26-08-2022

### Additions

- Add setting to change font size.
- Add line highlighting on cursor movement.
- Add template boilerplate for each language and implement language-wise local storage.

### Fixes / Improvements

- Fix cursor position for TAB button.
- Fix line numbering issues.
- Fix editor theme setting issues.
- Minor QOL updates.

### Known issues

- None as of now.

## 0.1.0 | 20-08-2022

### Additions

- Add local storage for language, tab switch and word wrap switch.
- Add option to save code on run.
- Add custom themed titlebar for desktop.

### Fixes / Improvements

- Fix bottom bar on smaller screen sizes.
- Make the output swipe handle smaller
- Implement adding content at cursor position instead of the start of the file.
- Add minimum size for split view on larger screen sizes.
- Minor QOL updates.

### Known issues

- Second point of 0.0.3 issues.

## 0.0.4 | 19-06-2022

### Additions

- Add tab space switching (2 and 4 spaces)

### Fixes / Improvements

- Fix janky output animation in mobile-like screen sizes.
- Make themes more uniform throughout the app.
- Minor QOL updates.
- Switched to stable flutter 3.0 release from dev branch.

### Deletions

- Removed useless always-on-keyboard switch.

### Known issues

- Bottom bar buttons append text to end of editor text.
- Second point of 0.0.3 issues.

## 0.0.3 | 12-05-2022

### Additions

- Added support for word wrapping in the editor
- Clear button and TAB, [], {} ... buttons are now functional
  **NOTE:** The text is appended to the existing text for now.
- Added dropdown search support for easy access to languages.
- Added local storage for themes, i.e, the app now remembers the app theme you last used.

### Fixes / Improvements

- Implemented a better way of rebuilding the editor part of the app.
- The editor now opens the output window when the run button is pressed
- Output window can now be accessed on long press of the button.

### Known issues

- Themeing is not consistent throughout the app yet
- On pressing buttons related to editing the text or changing the editor theme, the line numbering stops working.

## 0.0.2 | 15-04-2022

### Additions

- Added support for execution of multiple languages
- Added themes and per language themeing support

## 0.0.1 | 15-04-2022

### Additions

- Initial release for Android, Windows and the web
- Basic editor functionality
- Execution support for 3 languages
- Dark and Light themes

# Changelog

All notable changes to this project will be documented in this file.

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

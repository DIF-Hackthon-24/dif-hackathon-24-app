# Trial fonts
The trial fonts have been placed in this directory to allow the application to
render the fonts that will eventually be used in the released application.

The licensed fonts should be placed in the Application's Main repository. The `pubspec.yaml`
file of the main application should be updated to use those fonts.

Similarly, the font definition file (`text_styles.json`) should also be copied to the
main app repo. When intialising the application, the text files path should be overriden
to refer to the apps `text_styles.json` file. See the `PSTheme.initialise()` method.

Refer to the [trial license](https://www.daltonmaag.com/download/dama/TrialLicenceAgreement.pdf)
for terms and conditions.

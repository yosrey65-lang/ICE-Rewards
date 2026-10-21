# ICE Rewards — Flutter starter

This is a **UI starter project**, not a live rewards platform. It contains:
- English default UI and an English/Arabic language switch
- Home balance card
- Offerwall placeholders for OGAds, AdGem, and AdMaven
- Rewards and account tabs
- Demo points only (not redeemable)

## Run
1. Install Flutter SDK and Android Studio.
2. Extract this ZIP.
3. In the project folder run:
   ```bash
   flutter pub get
   flutter run
   ```
4. For Android release testing:
   ```bash
   flutter build apk --release
   ```

## Before production / Google Play
- Implement secure authentication and server-side balance ledger.
- Integrate each offer provider using its official publisher SDK/API/postback docs and approved account.
- Verify offer completions server-side; never trust points from the client app.
- Define redemption terms and implement fraud prevention, privacy policy, support contact, and required disclosures.
- Review current Google Play policies for rewards, ads, user data, and account deletion.
- Configure app signing, app icon, package ID, store listing, and test tracks.

## iOS later
Flutter allows sharing most app code, but iOS still needs an Apple developer account, Apple-specific testing/signing, and usually access to macOS/Xcode for the build.

## Important
The provider tiles are placeholders and do not open real offerwalls. No real earning, withdrawal, or provider connection is implemented in this starter.

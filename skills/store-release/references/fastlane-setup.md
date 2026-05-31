# Fastlane Setup

## Directory Structure

```
ios/fastlane/
  Appfile          # App identifiers and team info
  Fastfile         # Lane definitions
  Deliverfile      # App Store metadata settings
  Snapfile         # Screenshot configuration
  SnapshotHelper.swift  # UI test helper for screenshots
  metadata/        # App Store metadata (descriptions, keywords, etc.)
  screenshots/     # Generated screenshots
```

## Appfile

Configures app identity:
```ruby
app_identifier("com.virtual.<app-name>")  # Bundle ID
apple_id("travirt.virtual@gmail.com")    # Apple Developer email
itc_team_id("126841184")                 # App Store Connect Team ID
team_id("785YA752U9")                    # Developer Portal Team ID
```

**Per-app customization:** Each app needs its own Appfile with correct bundle ID and team info.

## Fastfile

### Lanes

**release**: Uploads pre-built IPA to App Store
```ruby
lane :release do
  ipa_path = Dir["../build/ios/ipa/*.ipa"].first
  UI.user_error!("IPA not found. Run 'make build-ipa' first.") unless ipa_path
  upload_to_app_store(ipa: ipa_path)
end
```

**screenshots**: Generates screenshots
```ruby
lane :screenshots do
  snapshot(devices: ["iPhone 15"])
end
```

## Dependencies

Fastlane requires Ruby and Bundler:
```bash
# Install (if not present)
gem install bundler
cd ios && bundle install

# Run lanes
cd ios && bundle exec fastlane <lane>
```

## Troubleshooting

| Issue | Fix |
|---|---|
| "Could not find IPA" | Run `make ipa` before `fastlane release` |
| Auth error | Check Apple ID credentials, may need app-specific password |
| "Invalid provisioning profile" | Regenerate in Apple Developer Portal, download in Xcode |
| Bundle version rejected | Increment build number (`make bump`) |
| Ruby/gem errors | `cd ios && bundle install` |

## Adding Fastlane to a New App

1. `cd apps/<app-name>/ios`
2. `bundle init` (or copy Gemfile from <app-name>)
3. Add `gem 'fastlane'` to Gemfile
4. `bundle install`
5. `bundle exec fastlane init`
6. Configure Appfile with app-specific identifiers
7. Copy/adapt Fastfile lanes from <app-name>

# j_rpc — Discord Rich Presence

This FiveM resource adds Discord Rich Presence support. It updates a player's Discord status with server information, a join button and a Discord invite button.

## Features
- Shows player name and server info in Discord Rich Presence
- Displays a large image asset (configured via `assetName`)
- Buttons for direct join (`fivem://connect/...`) and Discord invite

## Installation
1. Place the `j_rpc` folder inside your server's `resources` directory.
2. Add the following line to your `server.cfg` (or equivalent):

```
ensure j_rpc
```

3. Edit `discord_presence.lua` to set your Discord Application ID (`appId`) and asset names.

4. Make sure the shared scripts referenced in `fxmanifest.lua` are available on your server, or remove those `shared_script` lines if they're not needed.

## Configuration
- `discord_presence.lua` contains the main configuration at the top:
  - `appId` — your Discord application's Client ID
  - `assetName` — the name of the large image asset uploaded to your Discord application
  - `assetText` — tooltip text for the image asset
  - `discordLink` — your server/invite link

Edit these values and restart the resource.

## Notes
- The resource uses FiveM's Discord Rich Presence natives. Make sure your Discord application has assets configured and the client running Discord.

## License
This repository is licensed under the MIT License. See `LICENSE` for details.

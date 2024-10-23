notes from repo: https://github.com/dillacorn/deb12-i3-dots

For when FireFox/Librewolf isn't capable of the task.. or for compatibility reasons..

# start here
```sh
flatpak install io.github.ungoogled_software.ungoogled_chromium
```

open "Ungoogled Chromium"

# flags

navigate to: `chrome://flags/`

change these flags:
* [Handling of extension MIME type requests](chrome://flags/#extension-mime-request-handling): `Always prompt for install` <- allows for **chrome-web-store** to be installed
* [Disable search engine collection](chrome://flags/#disable-search-engine-collection): `Enabled`
* [Enable get*ClientRects() fingerprint deception](chrome://flags/#fingerprinting-client-rects-noise): `Enabled`
* [Enable Canvas::measureText() fingerprint deception](chrome://flags/#fingerprinting-canvas-measuretext-noise): `Enabled`
* [Enable Canvas image data fingerprint deception](chrome://flags/#fingerprinting-canvas-image-data-noise): `Enabled`
* [Anonymize local IPs exposed by WebRTC](chrome://flags/#enable-webrtc-hide-local-ips-with-mdns): `Enabled`
* [enable-webrtc-allow-input-volume-adjustment](chrome://flags/#enable-webrtc-allow-input-volume-adjustment): `Disabled` <- Browser adjusting mic volume randomly is so annoying
* [Preferred Ozone platform](chrome://flags/#ozone-platform-hint): `X11`

# chrome web store fix

make chrome web store work:

open Extensions Page: `chrome://extensions/`

enable `Developer mode` in the top right corner

reboot Ungoogled Chromium

navigate to : [`https://github.com/NeverDecaf/chromium-web-store`](https://github.com/NeverDecaf/chromium-web-store)

go to release page and click on `Chromium.Web.Store.crx` to install it

go install your extensions! -> [`https://chromewebstore.google.com/`](https://chromewebstore.google.com/)

# extensions

[`Chrome Show Tab Numbers`](https://chromewebstore.google.com/detail/chrome-show-tab-numbers/pflnpcinjbcfefgbejjfanemlgcfjbna)
[`uBlock Origin`](https://chromewebstore.google.com/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm)
[`LocalCDN`](https://chromewebstore.google.com/detail/localcdn/njdfdhgcmkocbgbhcioffdbicglldapd)
[`ClearURLs`](https://chromewebstore.google.com/detail/clearurls/lckanjgmijmafbedllaakclkaicjfmnk)
[`Privacy Badger`](https://chromewebstore.google.com/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp)
[`ScrollAnywhere`](https://chromewebstore.google.com/detail/scrollanywhere/jehmdpemhgfgjblpkilmeoafmkhbckhi)
[`Dark Reader`](https://chromewebstore.google.com/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh)
[`Key Jump keyboard navigation`](https://chromewebstore.google.com/detail/key-jump-keyboard-navigat/afdjhbmagopjlalgcjfclkgobaafamck)
[`Go Back With Backspace`](https://chromewebstore.google.com/detail/go-back-with-backspace/eekailopagacbcdloonjhbiecobagjci)
[`Bitwarden Password Manager`](https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb)
[`Google Translate`](https://chromewebstore.google.com/detail/google-translate/aapbdbdomjkkjkaonfhkkikfgjllcleb)
[`Honey`](https://chromewebstore.google.com/detail/honey-automatic-coupons-r/bmnlcjabgnpnenekpadlanbbkooimhnj)
[`Enhancer for YouTube`](https://chromewebstore.google.com/detail/enhancer-for-youtube/ponfpcnoihfmfllpaingbgckeeldkhle)
[`Return YouTube Dislike`](https://chromewebstore.google.com/detail/return-youtube-dislike/gebbhagfogifgggkldgodflihgfeippi)
[`DeArrow - Better Titles and Thumbnails`](https://chromewebstore.google.com/detail/dearrow-better-titles-and/enamippconapkdmgfgjchkhakpfinmaj)
[`Search by Image`](https://chromewebstore.google.com/detail/search-by-image/cnojnbdhbhnkbcieeekonklommdnndci)
[`DownThemAll!`](https://chromewebstore.google.com/detail/downthemall/nljkibfhlpcnanjgbnlnbjecgicbjkge)
[`FastForward`](https://chromewebstore.google.com/detail/fastforward/icallnadddjmdinamnolclfjanhfoafe)
[`SponsorBlock`](https://chromewebstore.google.com/detail/sponsorblock-for-youtube/mnjggcdmjocbbbhaepdhchncahnbgone)

# search engine

**search engine**: `(option #1)` - normally slower than brave

Name:
`disroot`

URL with %s in place of query
`https://search.disroot.org/search?q=%s`

**search engine**: `(option #2)` <- usually faster than disroot

Name:
`brave`

URL with %s in place of query
`https://search.brave.com/search?q=%s`

# custom dns server

navigate to `Privacy and security` in settings

enable `Use secure DNS`

add custom configured dns server from personal provider ~ I pay for nextdns ($2 a month)
### example dns server address

DNS-over-HTTPS: `https://dns.nextdns.io\xxxxxxx`

# test browser security
https://browserleaks.com/webrtc

# personal settings

navigate to `appearance`

enable `classic` theme

choose mode `Dark`

enable `Show home button` and add my personal `flame` domain running on my personal OpenMediaVault NAS.

disable `Show bookmarks bar`

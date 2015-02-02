# Setup
{selectXPath} = require "casper"
utils = require("clientutils").create();

casper.options.viewportSize =
  width: 1024
  height: 768
casper.options.verbose = yes
casper.options.logLevel = "info"
casper.options.waitTimeout = 50000

screenshot = "./screenfiles/"
uri = "http://rdpanek.cz/"
expectedTitle = "Radim Daniel Pánek | Test Automation Engineer"

dataProvider = [
  [
    "fa-twitter",
    "https://twitter.com/rdpanek",
    ///Twitter///,
    "Twitter"
  ],
  [
    "fa-linkedin",
    "http://cz.linkedin.com/pub/radim-daniel-pánek/10/1aa/585/",
    ///LinkedIn///,
    "LinkedIn"
  ],
  [
    "fa-github-alt",
    "https://github.com/rdpanek",
    ///GitHub///,
    "GitHub"
  ],
  [
    "fa-youtube-play",
    "https://www.youtube.com/user/developerhub/videos",
    ///YouTube///,
    "YouTube"
  ],
  [
    "fa-instagram",
    "http://instagram.com/rdpanek/",
    ///Instagram///,
    "Instagram"
  ],
  [
    "fa-link",
    "http://rdpanek.postach.io",
    ///RDPanek///,
    "Postachio"
  ],
  [
    "fa-link",
    "http://cz.linkedin.com/pub/radim-daniel-pánek/10/1aa/585/",
    ///LinkedIn///,
    "LinkedIn"
  ],
  [
    "fa-dropbox",
    "http://bit.ly/RDPanekTestingBooks",
    ///Dropbox///,
    "Dropbox"
  ],
  [
    "fa-google-plus-square",
    "https://plus.google.com/104430691967816421534/about",
    ///DeveloperHub///,
    "{ DeveloperHub G+}"
  ],
  [
    "fa-google-plus-square",
    "https://plus.google.com/113924472420940718852/about",
    ///Spaghetti///,
    "GDGSCL G+"
  ]
]
count = 0

# hooks
casper.on "capture", ->
  "use strict"
  if @.exists "body"
    @.capture "#{screenshot}step_#{@.status().step}_#{Date.now()}.jpg"

removeLinkTargetsAttribute = ->
  "use strict"
  casper.evaluate ->
    [].forEach.call utils.findAll("a"), (link) ->
      link.removeAttribute "target"

# TestCase
casper.test.begin "Jako kovářova kobyla - tak aby nechodila bosa", 21, (test) ->
  "use strict"
  casper.start uri, ->
    @.test.assertTitle expectedTitle

  casper.repeat dataProvider.length, ->
    site = dataProvider[count]
    @.waitForSelector "i.fa.#{site[0]}", ->
      removeLinkTargetsAttribute()
      @.click selectXPath "//a[contains(@href,'#{site[1]}')]",
      @.waitForSelector "title", ->
        @.test.assertTitleMatch site[2], "Jsem na stránce #{site[3]}"
        casper.back()
        casper.waitForSelector "title", ->
          @.test.assertTitle expectedTitle, "Jsem zpět na mém webu"
          count++

  # casper.then ->
  #   @.wait 15000
    #@.emit 'capture'
    #test.assertElementCount selectXPath("//ol[@class='h-feed'/li]"), 21

  casper.run ->
    test.done()
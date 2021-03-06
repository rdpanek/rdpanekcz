// Generated by CoffeeScript 1.8.0
var count, dataProvider, expectedTitle, removeLinkTargetsAttribute, screenshot, selectXPath, uri, __utils__;

selectXPath = require("casper").selectXPath;

__utils__ = require("clientutils").create();

casper.options.viewportSize = {
  width: 1024,
  height: 768
};

casper.options.verbose = true;

casper.options.logLevel = "info";

casper.options.waitTimeout = 50000;

screenshot = "./screenfiles/";

uri = "http://rdpanek.cz/";

expectedTitle = "Radim Daniel Pánek | Test Automation Engineer";

dataProvider = [["fa-twitter", "https://twitter.com/rdpanek", /Twitter/, "Twitter"], ["fa-linkedin", "http://cz.linkedin.com/pub/radim-daniel-pánek/10/1aa/585/", /LinkedIn/, "LinkedIn"], ["fa-github-alt", "https://github.com/rdpanek", /GitHub/, "GitHub"], ["fa-youtube-play", "https://www.youtube.com/user/developerhub/videos", /YouTube/, "YouTube"], ["fa-instagram", "http://instagram.com/rdpanek/", /Instagram/, "Instagram"], ["fa-link", "http://rdpanek.postach.io", /RDPanek/, "Postachio"], ["fa-link", "http://cz.linkedin.com/pub/radim-daniel-pánek/10/1aa/585/", /LinkedIn/, "LinkedIn"], ["fa-dropbox", "http://bit.ly/RDPanekTestingBooks", /Dropbox/, "Dropbox"], ["fa-google-plus-square", "https://plus.google.com/104430691967816421534/about", /DeveloperHub/, "{ DeveloperHub G+}"], ["fa-google-plus-square", "https://plus.google.com/113924472420940718852/about", /Spaghetti/, "GDGSCL G+"]];

count = 0;

casper.on("capture", function() {
  "use strict";
  if (this.exists("body")) {
    return this.capture("" + screenshot + "step_" + (this.status().step) + "_" + (Date.now()) + ".jpg");
  }
});

removeLinkTargetsAttribute = function() {
  "use strict";
  return casper.evaluate(function() {
    return [].forEach.call(__utils__.findAll("a"), function(link) {
      return link.removeAttribute("target");
    });
  });
};

casper.test.begin("Jako kovářova kobyla - tak aby nechodila bosa", 21, function(test) {
  "use strict";
  casper.start(uri, function() {
    return this.test.assertTitle(expectedTitle);
  });
  casper.repeat(dataProvider.length, function() {
    var site;
    site = dataProvider[count];
    return this.waitForSelector("i.fa." + site[0], function() {
      removeLinkTargetsAttribute();
      return this.click(selectXPath("//a[contains(@href,'" + site[1] + "')]", this.waitForSelector("title", function() {
        this.test.assertTitleMatch(site[2], "Jsem na stránce " + site[3]);
        casper.back();
        return casper.waitForSelector("title", function() {
          this.test.assertTitle(expectedTitle, "Jsem zpět na mém webu");
          return count++;
        });
      })));
    });
  });
  return casper.run(function() {
    return test.done();
  });
});

jQuery(document).ready(function($) {
  /* Bootstrap Tooltip for Skillset */
  $(".level-label").tooltip();

  /* Github Activity Feed - https://github.com/caseyscarborough/github-activity */
  GitHubActivity.feed({
    username: "rdpanek",
    selector: "#githubFeed",
    limit: 5
  });
});

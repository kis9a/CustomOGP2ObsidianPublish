"use strict";

// template variables
var BASE_URL = "${BASE_URL}";
var TITLE = "${TITLE}";
var DESCRIPTION = "${DESCRIPTION}";
var IMAGE = "${IMAGE}";
var IMAGE_TYPE = "${IMAGE_TYPE}";

// target bots
var BOTS = [
  "Twitterbot",
  "facebookexternalhit",
  "line-poker",
  "Discordbot",
  "SkypeUriPreview",
  "Slackbot-LinkExpanding",
  "PlurkBot",
];

var getResponseBody = (url) => {
  let str = `
    <!doctype html>
    <head>
      <meta charset="utf-8" />
      <meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
      <meta content="width=device-width, initial-scale=1.0" name="viewport" />
      <title>${TITLE}</title>
      <meta content="${DESCRIPTION}" name="description">

      <meta content="UURL" property="og:url" />
      <meta content="website" property="og:type" />
      <meta content="${TITLE}" property="og:title" />
      <meta content="${DESCRIPTION}" property="og:description" />
      <meta content="${IMAGE}" property="og:image" />
      <meta content="${IMAGE}" property="og:image:secure_url" />
      <meta content="${IMAGE_TYPE}" property="og:image:type" />

      <meta content="summary" property="twitter:card" />
      <meta content="${TITLE}" property="twitter:site" />
      <meta content="${TITLE}" property="twitter:title" />
      <meta content="${DESCRIPTION}" property="twitter:description" />
      <meta content="${IMAGE}" property="twitter:image" />
    </head>
    <body>
    </body>
    </html>
`;

  // Replace specific text, because conflict template engine between  terraform and JavaScript
  return str.replace("UURL", url);
};

exports.handler = function (event, ctx, callback) {
  var req = event.Records[0].cf.request;
  var userAgent = req.headers["user-agent"][0].value;
  var isBot = BOTS.some((v) => {
    return userAgent.includes(v);
  });
  if (isBot) {
    var path = req.uri;
    var url = BASE_URL + path + "?" + req.querystring;

    let body;
    switch (path) {
      default:
        body = getResponseBody(url);
    }

    var res = {
      status: "200",
      statusDescription: "OK",
      headers: {
        "content-type": [
          {
            key: "Content-Type",
            value: "text/html",
          },
        ],
      },
      body,
    };
    callback(null, res);
  } else {
    callback(null, req);
  }
};

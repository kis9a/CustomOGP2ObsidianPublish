## CustomOGP2ObsidianPublish

Setup custom OGP with Lambda@Edge for Obsidian Publish website. I found the following issue on the forum [Publish: Support openGraph / twitter metadata in for embeds](https://forum.obsidian.md/t/publish-support-opengraph-twitter-metadata-in-head-for-embeds/31064). But, presumably OGP is not officially supported by Obsidian Publish. I used Lambda@Edge to deal with it.

### Overview for realize

A Lambda@Edge function can generate HTTP responses when CloudFront `origin request`(Before CloudFront forwards a request to the origin) events occur. Generates OGP HTML and returns a response in the case of a request from a bot. This module builds on the configuration of custom domain settings introduced in the previous article ([Obsidian Publish のカスタムドメインを設定](https://md.kis9a.com/articles/Obsidian+Publish+のカスタムドメインを設定)). Therefore, just associate the Lambda@Edge function created in the previous configuration ([github.com/kis9a/CustomDomain2ObsidianPublish](https://github.com/kis9a/CustomDomain2ObsidianPublish)) to CloudFront.

### How to use this module

See example/ directory, you need to customize backend configuration(backend.tf), provider parameters(provider.tf), data source (data.tf), this module parameters (modules.tf) for you.

- Example <https://md.kis9a.com>

```bash
curl -H "User-Agent: Twitterbot" -s https://md.kis9a.com
```

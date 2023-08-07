# SEO Pages

[![Netlify Status](https://api.netlify.com/api/v1/badges/87e236c7-b801-4a6c-9125-c4f5abc39585/deploy-status)](https://app.netlify.com/sites/frolicking-longma-3a99db/deploys)

## Deployment
First build jekyll `bundle exec jekyll build` then build the stylesheet `yarn run build`.

## Development
Run `./bin/dev` to start jekyll and tailwind processes.

## Notes

### baseurl

`baseurl` configuration is used to set the /connectors subpath as the main path for the website.

All relative URLs must be built as `{{ site.baseuri }}/path`.

This is because the reverse proxy is configured to send all `/connectors/*` requests to this website.

### permalink

All connector pages must set the permalink attribute in their frontmatter.

```markdown
---
title: "LinkedIn Connector"
permalink: linkedin
...
---
```

The permalink is used as the final destination of the page. For instance, for the example above the final destination will be: `/connectors/linkedin`.

`/connectors` is prepended automatically because of the `baseurl`.

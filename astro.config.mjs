import { defineConfig } from 'astro/config';
import partytown from "@astrojs/partytown";
import robotsTxt from "astro-robots-txt";

const githubUsername = import.meta.env.GITHUB_REPOSITORY_OWNER || 'INSERT_GITHUB_USERNAME_HERE';

// https://astro.build/config
export default defineConfig({
  integrations: [
    partytown(),
    robotsTxt({
      sitemap: false,
      policy: [
        {
          userAgent: '*',
          disallow: ['/'],
        }
      ],
    }),
  ],
  site: `https://${githubUsername}.github.io`
});

import { readFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { defineConfig } from "vitepress";

const productionUrl = "https://health-connector.phamtunglam.com";
const repositoryUrl = "https://github.com/fam-tung-lam/health_connector";
const repositoryRoot = resolve(dirname(fileURLToPath(import.meta.url)), "../..");
const packageVersion = readFileSync(
  resolve(repositoryRoot, "packages/health_connector/pubspec.yaml"),
  "utf8",
).match(/^version:\s*(\S+)/m)?.[1];

if (!packageVersion) {
  throw new Error("packages/health_connector/pubspec.yaml has no version.");
}

/**
 * The guide is ordered the way an integration actually happens: decide, install,
 * ship something small, then learn the model, then perform individual tasks.
 */
const guideSidebar = [
  {
    text: "Start here",
    items: [
      { text: "What is Health Connector SDK?", link: "/guide/" },
      { text: "Install & configure", link: "/guide/installation" },
      { text: "Your first integration", link: "/guide/quickstart" },
      { text: "Setup troubleshooting", link: "/guide/troubleshooting" },
    ],
  },
  {
    text: "Core concepts",
    collapsed: false,
    items: [
      { text: "Architecture", link: "/guide/concepts/architecture" },
      { text: "Health records", link: "/guide/concepts/records" },
      { text: "Measurement units", link: "/guide/concepts/units" },
      { text: "Data types & capabilities", link: "/guide/concepts/data-types" },
      { text: "Permissions", link: "/guide/concepts/permissions" },
      { text: "Platform differences", link: "/guide/concepts/platform-differences" },
    ],
  },
  {
    text: "Tasks",
    collapsed: false,
    items: [
      { text: "Request permissions", link: "/guide/tasks/permissions" },
      { text: "Read records", link: "/guide/tasks/read" },
      { text: "Write records", link: "/guide/tasks/write" },
      { text: "Update records", link: "/guide/tasks/update" },
      { text: "Delete records", link: "/guide/tasks/delete" },
      { text: "Aggregate data", link: "/guide/tasks/aggregate" },
      { text: "Synchronize incrementally", link: "/guide/tasks/synchronize" },
      { text: "Read & write exercise routes", link: "/guide/tasks/exercise-routes" },
      { text: "Check platform features", link: "/guide/tasks/features" },
      { text: "Handle errors", link: "/guide/tasks/errors" },
      { text: "Configure logging", link: "/guide/tasks/logging" },
    ],
  },
];

const recipesSidebar = [
  {
    text: "Recipes",
    items: [
      { text: "Overview", link: "/recipes/" },
      { text: "Nutrition & hydration", link: "/recipes/nutrition" },
      { text: "Sleep tracking", link: "/recipes/sleep" },
      { text: "Mindfulness & behavioral health", link: "/recipes/mindfulness" },
      { text: "Fitness & activity tracking", link: "/recipes/fitness" },
    ],
  },
];

const referenceSidebar = [
  {
    text: "Reference",
    items: [
      { text: "Overview", link: "/reference/" },
      { text: "API cheat sheet", link: "/reference/api-cheat-sheet" },
      { text: "Health data types", link: "/reference/health-data-types" },
      { text: "Exercise types", link: "/reference/exercise-types" },
      { text: "Error codes", link: "/reference/error-codes" },
      { text: "Annotations", link: "/reference/annotations" },
      { text: "Platform support", link: "/reference/platform-support" },
      { text: "Requirements", link: "/reference/requirements" },
      { text: "Packages", link: "/reference/packages" },
    ],
  },
];

const resourcesSidebar = [
  {
    text: "Resources",
    items: [
      { text: "Toolbox demo app", link: "/resources/toolbox" },
      { text: "Migration guides", link: "/resources/migration" },
      { text: "Project & community", link: "/resources/project" },
    ],
  },
];

const everySidebar = [
  ...guideSidebar,
  ...recipesSidebar,
  ...referenceSidebar,
  ...resourcesSidebar,
];

export default defineConfig({
  lang: "en-US",
  title: "Health Connector SDK",
  titleTemplate: ":title | Health Connector SDK",
  description:
    "A unified, type-safe Flutter SDK for Android Health Connect and iOS HealthKit.",
  base: "/",
  cleanUrls: true,
  lastUpdated: true,
  metaChunk: true,
  sitemap: { hostname: productionUrl },
  head: [
    ["meta", { name: "theme-color", content: "#087f5b" }],
    ["link", { rel: "icon", type: "image/svg+xml", href: "/favicon.svg" }],
    [
      "meta",
      {
        name: "keywords",
        content:
          "Flutter health SDK, Health Connect, HealthKit, health_connector, Dart, Apple Health",
      },
    ],
    ["meta", { property: "og:type", content: "website" }],
    ["meta", { property: "og:url", content: productionUrl }],
    ["meta", { property: "og:title", content: "Health Connector SDK" }],
    [
      "meta",
      {
        property: "og:description",
        content:
          "One type-safe Flutter API for Android Health Connect and iOS HealthKit.",
      },
    ],
    ["meta", { property: "og:image", content: `${productionUrl}/og.png` }],
    ["meta", { name: "twitter:card", content: "summary_large_image" }],
    ["meta", { name: "twitter:title", content: "Health Connector SDK" }],
    [
      "meta",
      {
        name: "twitter:description",
        content:
          "One type-safe Flutter API for Android Health Connect and iOS HealthKit.",
      },
    ],
    ["meta", { name: "twitter:image", content: `${productionUrl}/og.png` }],
  ],
  markdown: {
    theme: { light: "github-light", dark: "github-dark" },
    lineNumbers: false,
    container: {
      tipLabel: "TIP",
      warningLabel: "HEADS UP",
      dangerLabel: "IMPORTANT",
      infoLabel: "NOTE",
      detailsLabel: "Details",
    },
  },
  themeConfig: {
    logo: { light: "/logo.svg", dark: "/logo.svg", alt: "Health Connector SDK" },
    nav: [
      { text: "Guide", link: "/guide/", activeMatch: "^/guide/" },
      { text: "Recipes", link: "/recipes/", activeMatch: "^/recipes/" },
      { text: "Reference", link: "/reference/", activeMatch: "^/reference/" },
      {
        text: `v${packageVersion}`,
        items: [
          { text: "Changelog", link: "https://pub.dev/packages/health_connector/changelog" },
          { text: "Migration guides", link: "/resources/migration" },
          { text: "Toolbox demo app", link: "/resources/toolbox" },
          { text: "Project & community", link: "/resources/project" },
          { text: "pub.dev", link: "https://pub.dev/packages/health_connector" },
        ],
      },
    ],
    sidebar: {
      "/guide/": guideSidebar,
      "/recipes/": recipesSidebar,
      "/reference/": referenceSidebar,
      "/resources/": everySidebar,
    },
    search: {
      provider: "local",
      options: {
        detailedView: true,
        miniSearch: {
          searchOptions: { fuzzy: 0.2, prefix: true, boost: { title: 4, text: 2 } },
        },
      },
    },
    socialLinks: [
      { icon: "github", link: repositoryUrl, ariaLabel: "Health Connector SDK on GitHub" },
    ],
    editLink: {
      pattern: `${repositoryUrl}/edit/main/webapp/:path`,
      text: "Suggest an edit to this page",
    },
    footer: {
      message: "Released under the MIT License.",
      copyright: "Copyright © Pham Tung Lam",
    },
    outline: { level: [2, 3], label: "On this page" },
    docFooter: { prev: "Previous", next: "Next" },
    lastUpdatedText: "Last updated",
  },
});

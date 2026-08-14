import type { Theme } from "vitepress";
import DefaultTheme from "vitepress/theme";
import ThemeLayout from "./Layout.vue";
import ArchitectureDiagram from "./components/ArchitectureDiagram.vue";
import CopyButton from "./components/CopyButton.vue";
import DataTypeExplorer from "./components/DataTypeExplorer.vue";
import ErrorCodeExplorer from "./components/ErrorCodeExplorer.vue";
import ExerciseTypeExplorer from "./components/ExerciseTypeExplorer.vue";
import NextSteps from "./components/NextSteps.vue";
import PlatformTabs from "./components/PlatformTabs.vue";
import StatBand from "./components/StatBand.vue";
import "./custom.css";

export default {
  extends: DefaultTheme,
  Layout: ThemeLayout,
  enhanceApp({ app }) {
    // Registered globally so pages can stay in plain Markdown.
    app.component("ArchitectureDiagram", ArchitectureDiagram);
    app.component("CopyButton", CopyButton);
    app.component("DataTypeExplorer", DataTypeExplorer);
    app.component("ErrorCodeExplorer", ErrorCodeExplorer);
    app.component("ExerciseTypeExplorer", ExerciseTypeExplorer);
    app.component("NextSteps", NextSteps);
    app.component("PlatformTabs", PlatformTabs);
    app.component("StatBand", StatBand);
  },
} satisfies Theme;

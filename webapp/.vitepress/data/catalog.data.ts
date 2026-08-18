import { readFileSync } from "node:fs";
import { basename } from "node:path";
import { defineLoader } from "vitepress";
import { parse } from "yaml";

interface NativeApi {
  label: string;
  url?: string;
  note?: string;
}

export interface HealthDataTypeEntry {
  name: string;
  description: string;
  constant: string;
  aggregations: string[];
  android: boolean;
  ios: boolean;
  androidNote?: string;
  iosNote?: string;
  androidApi?: NativeApi;
  iosApi?: NativeApi;
  category: string;
  group: string;
}

export interface ExerciseTypeEntry {
  constant: string;
  name: string;
  android: boolean;
  ios: boolean;
}

export type ErrorPlatform = "both" | "android" | "ios";

export interface ErrorCodeEntry {
  code: string;
  exception: string;
  platform: ErrorPlatform;
  developerError?: boolean;
  retryable?: boolean;
  cause: string;
  recovery: string;
}

export interface CatalogData {
  totals: {
    dataTypes: number;
    exerciseTypes: number;
    android: number;
    ios: number;
    aggregatable: number;
  };
  categories: string[];
  dataTypes: HealthDataTypeEntry[];
  exerciseTypes: ExerciseTypeEntry[];
  errorCodes: ErrorCodeEntry[];
}

declare const data: CatalogData;
export { data };

function loadList<T>(watchedFiles: string[], fileName: string): T[] {
  const path = watchedFiles.find((file) => basename(file) === fileName);
  if (!path) throw new Error(`VitePress catalog source not found: ${fileName}`);

  const value: unknown = parse(readFileSync(path, "utf8"));
  if (!Array.isArray(value)) {
    throw new TypeError(`${fileName} must contain a YAML list.`);
  }

  return value as T[];
}

function assertUnique(values: string[], source: string): void {
  const duplicate = values.find((value, index) => values.indexOf(value) !== index);
  if (duplicate) throw new Error(`${source} contains duplicate key: ${duplicate}`);
}

export default defineLoader({
  watch: [
    "../../../SUPPORTED_HEALTH_DATA_TYPES.yml",
    "../../../SUPPORTED_EXERCISE_TYPES.yml",
    "../../../HEALTH_CONNECTOR_ERROR_CODES.yml",
  ],
  load(watchedFiles): CatalogData {
    const dataTypes = loadList<HealthDataTypeEntry>(
      watchedFiles,
      "SUPPORTED_HEALTH_DATA_TYPES.yml",
    );
    const exerciseTypes = loadList<ExerciseTypeEntry>(
      watchedFiles,
      "SUPPORTED_EXERCISE_TYPES.yml",
    );
    const errorCodes = loadList<ErrorCodeEntry>(
      watchedFiles,
      "HEALTH_CONNECTOR_ERROR_CODES.yml",
    );

    assertUnique(
      dataTypes.map((entry) => entry.constant),
      "SUPPORTED_HEALTH_DATA_TYPES.yml",
    );
    assertUnique(
      exerciseTypes.map((entry) => entry.constant),
      "SUPPORTED_EXERCISE_TYPES.yml",
    );
    assertUnique(
      errorCodes.map((entry) => entry.code),
      "HEALTH_CONNECTOR_ERROR_CODES.yml",
    );

    return {
      totals: {
        dataTypes: dataTypes.length,
        exerciseTypes: exerciseTypes.length,
        android: dataTypes.filter((entry) => entry.android).length,
        ios: dataTypes.filter((entry) => entry.ios).length,
        aggregatable: dataTypes.filter((entry) => entry.aggregations.length > 0)
          .length,
      },
      categories: [...new Set(dataTypes.map((entry) => entry.category))],
      dataTypes,
      exerciseTypes,
      errorCodes,
    };
  },
});

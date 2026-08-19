import assert from 'node:assert/strict';
import { execFileSync } from 'node:child_process';
import { mkdtemp, readFile, rm, writeFile } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { delimiter, join, resolve } from 'node:path';
import test from 'node:test';

test('package tag creation reaches the matching push command', async () => {
  const temporaryDirectory = await mkdtemp(join(tmpdir(), 'release-package-tags-test-'));
  const gitLogPath = join(temporaryDirectory, 'git.log');
  const gitPath = join(temporaryDirectory, 'git');

  await writeFile(
    gitPath,
    `#!/bin/sh
printf '%s\n' "$*" >> "$GIT_LOG"
if [ "$1" = "show-ref" ]; then
  exit 1
fi
`,
    { mode: 0o755 },
  );

  try {
    execFileSync(process.execPath, ['scripts/release-package-tags.mjs', '--push'], {
      cwd: resolve('.'),
      env: {
        ...process.env,
        GITHUB_ACTIONS: 'false',
        GIT_LOG: gitLogPath,
        PATH: `${temporaryDirectory}${delimiter}${process.env.PATH}`,
      },
    });

    const commands = (await readFile(gitLogPath, 'utf8')).trim().split('\n');
    const tagCommands = commands.filter((command) => command.startsWith('tag --annotate '));
    const pushCommands = commands.filter((command) => command.startsWith('push origin refs/tags/'));

    assert.equal(tagCommands.length, 6);
    assert.equal(pushCommands.length, 6);

    for (const [index, tagCommand] of tagCommands.entries()) {
      const tag = tagCommand.split(' ')[2];
      assert.equal(pushCommands[index], `push origin refs/tags/${tag}`);
    }
  } finally {
    await rm(temporaryDirectory, { force: true, recursive: true });
  }
});

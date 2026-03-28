# JS Development

> Node.js ecosystem tooling. Runtime versions managed by mise; packages via pnpm or bun.

## Runtime management (mise)

mise manages Node, bun, and any other runtime versions per-project.

```bash
mise use node@lts             # set Node version for this project (.mise.toml)
mise use --global node@lts    # set global default
mise use --global bun@latest  # install bun globally
mise install                  # install all tools defined in .mise.toml
mise current                  # show active versions
```

`.mise.toml` (commit this to your project):
```toml
[tools]
node = "lts"
bun  = "latest"
```

## pnpm — fast package manager

```bash
pnpm install           # install deps (uses lockfile)
pnpm add lodash        # add a package
pnpm add -D typescript # add a dev dep
pnpm run dev           # run a script
pnpm dlx create-next-app@latest   # run a package without installing
```

pnpm is a drop-in replacement for npm. Saves disk space with a content-addressable store.

## bun — ultra-fast runtime + package manager

```bash
bun install            # install deps (very fast)
bun run dev            # run scripts
bun add lodash
bun x create-next-app@latest   # like npx
bun test               # built-in test runner
```

## LazyVim TypeScript support

TypeScript extra is enabled in `lazyvim.json`:
```
lazyvim.plugins.extras.lang.typescript
```

Provides: LSP (tsserver), formatting (prettier), linting (eslint), auto-imports.

## nvm (legacy)

nvm is still loaded in `.zshrc` for backward compatibility. Migrate projects to mise gradually with `.mise.toml`.

## Notes

- pnpm global bin is in `~/.local/share/pnpm` — already in PATH via `.zshrc`
- bun installs to `~/.bun/bin` — mise handles this when installed via `mise use --global bun@latest`

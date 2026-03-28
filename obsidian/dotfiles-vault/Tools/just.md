# just — Task Runner

> A command runner for project-specific tasks. Like `make` but without the 40-year-old baggage.

## Why just (over make)

- **Simple syntax**: No tabs vs spaces nonsense, no implicit rules to memorise
- **Recipes**: Define tasks in a `justfile` at the project root
- **Shell-first**: Each recipe is just a shell script — no DSL to learn
- **Cross-platform**: Works on Linux, macOS, Windows

## Example justfile

```just
# List available recipes
default:
    @just --list

# Build the project
build:
    cargo build --release

# Run tests
test:
    cargo test

# Format + lint
check:
    cargo fmt && cargo clippy

# Docker compose helpers
up:
    docker compose up -d

down:
    docker compose down

logs:
    docker compose logs -f
```

## Usage

```bash
just          # runs default recipe (or lists if default is @just --list)
just build    # run the 'build' recipe
just test     # run the 'test' recipe
just -l       # list all available recipes
```

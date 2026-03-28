# lazysql

> Terminal-based TUI for querying SQL databases. Keyboard-driven, stays in the terminal.

## MariaDB / MySQL support

Yes — lazysql connects to MariaDB using the standard MySQL driver:

```bash
lazysql -u root -p password -h 127.0.0.1 -P 3306 -d mydb --driver mysql
```

## lazysql vs DBeaver

| | lazysql | DBeaver |
|---|---------|---------|
| Interface | Terminal TUI | GUI |
| Speed | Instant, keyboard-driven | Feature-rich, slower |
| ER Diagrams | ✗ | ✓ |
| Visual data editing | Basic | Full |
| Best for | Quick queries, no context-switch | Schema exploration, data analysis |

**Use both** — lazysql for quick terminal queries, DBeaver for deeper work.

## Supported databases

MySQL, MariaDB, PostgreSQL, SQLite, Oracle, MSSQL

## Key bindings

| Key | Action |
|-----|--------|
| `Tab` | Switch between panels |
| `Enter` | Execute query |
| `?` | Help |
| `q` / `Ctrl+C` | Quit |

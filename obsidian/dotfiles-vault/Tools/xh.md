# xh — Modern HTTP Client

> Fast, friendly HTTP client written in Rust. Drop-in replacement for HTTPie with zero startup cost.

## Why xh (over curl / httpie)

- **HTTPie-compatible syntax** — `xh GET example.com` just works
- **Fast**: Rust binary, no Python startup lag like HTTPie
- **Pretty output**: JSON auto-formatted and syntax-highlighted by default
- **Sessions, redirects, file uploads** — everything HTTPie does

## Usage

```bash
xh get httpbin.org/get
xh post httpbin.org/post name=Chris lang=zsh   # JSON body auto-inferred
xh get api.github.com/users/octocat Accept:application/vnd.github+json
xh --auth user:pass post example.com/login
xh -d get example.com/file.zip                 # download file
```

## Alias

```zsh
alias http='xh'   # httpie-compatible name
```

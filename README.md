# dev-env

A containerized development environment for Node.js, Go, and general purpose development.

## Tools Included

| Tool | Version | Purpose |
|------|---------|---------|
| Node.js | 22.x | JavaScript runtime |
| pnpm | latest | Package manager |
| Go | 1.25.5 | Go development |
| Bun | latest | Fast JS runtime/bundler |
| Neovim | latest | Editor (with LazyVim) |
| gh | latest | GitHub CLI |
| zsh | 5.9 | Shell (with Oh My Zsh) |
| ripgrep | - | Fast search |
| fd | - | Fast find |
| fzf | - | Fuzzy finder |

## Quick Start

```bash
# Build and start
docker compose up -d

# Enter the container
docker compose exec dev zsh

# Or directly
docker exec -it dev-env zsh
```

## Persistent Volumes

All data survives container restarts:

| Volume | Mount Point | Purpose |
|--------|-------------|---------|
| `dev-projects` | `/root/dev` | Project repos |
| `dev-config` | `/root/.config` | gh, nvim config |
| `dev-local` | `/root/.local` | nvim plugins, data |
| `dev-cache` | `/root/.cache` | pnpm cache |
| `dev-go` | `/root/go` | GOPATH |
| `dev-ohmyzsh` | `/root/.oh-my-zsh` | Oh My Zsh |

## First-Time Setup

After starting the container:

1. **Authenticate GitHub:**
   ```bash
   gh auth login
   ```

2. **Clone your repos:**
   ```bash
   cd /root/dev
   git clone https://github.com/your-username/your-repo.git
   ```

3. **Run nvim once** to install LazyVim plugins:
   ```bash
   nvim
   ```

## Resource Limits

- **Memory:** 4GB
- **CPUs:** 2 cores

Adjust in `docker-compose.yml` under `deploy.resources.limits`.

## Management

```bash
# Stop
docker compose stop

# Start
docker compose start

# Rebuild (after Dockerfile changes)
docker compose build
docker compose up -d

# View logs
docker compose logs -f

# Remove (preserves volumes)
docker compose down

# Remove including volumes (destructive!)
docker compose down -v
```

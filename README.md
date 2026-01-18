# BiblioGenius - Docker Environment

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/docker-compose-blue)](https://www.docker.com/)

**Instant local development environment for the BiblioGenius ecosystem.**

This repository provides a `docker-compose` setup to run the Rust backend, P2P simulation nodes, and associated services (like FrankenPHP) with a single command.

## 🚀 Services

- **Rust Server Primary**: `http://localhost:8001`
- **Rust Server Beta** (P2P Peer): `http://localhost:8002`
- **FrankenPHP**: Service orchestration.

## 📋 Prerequisites

- **Docker Desktop** or **Docker Engine** + **Compose**

## ⚡ Quick Start

```bash
# Clone repository
git clone https://github.com/bibliogenius/bibliogenius-docker.git
cd bibliogenius-docker

# Start services
docker-compose up -d
```

To stop services:

```bash
docker-compose down
```

## 🛠️ Usage

### Viewing Logs

```bash
# Follow logs for all services
docker-compose logs -f

# Follow logs for specific service
docker-compose logs -f rust_server_1
```

### Rebuilding

If you've updated the source code and need to rebuild containers:

```bash
docker-compose up -d --build
```

## 🔗 Related Repositories

- [**bibliogenius**](https://github.com/bibliogenius/bibliogenius): The source code for the Rust servers.
- [**bibliogenius-app**](https://github.com/bibliogenius/bibliogenius-app): The frontend client application.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

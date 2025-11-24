# BiblioGenius Docker - Development Environment

Docker Compose setup for local development of the BiblioGenius ecosystem.

## Services

- **bibliogenius-a**: Rust server instance A (port 8001)
- **bibliogenius-b**: Rust server instance B (port 8002) - for P2P testing
- **hub**: Symfony hub (port 8080)
- **postgres**: PostgreSQL database for hub
- **redis**: Redis cache for hub

## Quick Start

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop all services
docker-compose down
```

## Access Points

- Rust Server A: http://localhost:8001
- Rust Server B: http://localhost:8002
- Symfony Hub: http://localhost:8080
- Hub Admin: http://localhost:8080/admin

## Testing P2P

1. Start both Rust servers
2. Register both with the hub
3. Use discovery API to find peers
4. Test synchronization between servers

## Environment Variables

Copy `.env.example` to `.env` and customize:

```env
# Rust Server
DATABASE_URL=sqlite:///data/library.db
JWT_SECRET=your-secret-key

# Symfony Hub
DATABASE_URL=postgresql://bibliogenius:secret@postgres:5432/bibliogenius_hub
REDIS_URL=redis://redis:6379
```

## Documentation

See [POC_ROADMAP.md](../docs/POC_ROADMAP.md) for integration testing.

## Repository

https://github.com/bibliogenius/bibliogenius-docker

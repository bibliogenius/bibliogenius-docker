# BiblioGenius Docker - Quick Start Guide

## 🚀 One-Command Start

```bash
cd /Users/federico/Sites/bibliotech/bibliogenius-docker
docker-compose up -d
```

That's it! All services will start automatically with **FrankenPHP** (modern PHP server).

## 📦 What Gets Started

- **Rust Server A**: http://localhost:8001
- **Rust Server B**: http://localhost:8002 (for P2P testing)
- **Symfony Hub** (FrankenPHP): http://localhost:8080
- **Admin Dashboard**: http://localhost:8080/admin

## 🧪 Test the POC

### 1. Check Services are Running

```bash
# Check all containers
docker-compose ps

# Should show 3 containers running:
# - bibliogenius-a
# - bibliogenius-b
# - bibliogenius-hub (FrankenPHP)
```

### 2. Test Rust Server A

```bash
# Health check
curl http://localhost:8001/api/health

# Add a book
curl -X POST http://localhost:8001/api/books \
  -H "Content-Type: application/json" \
  -d '{
    "title": "The Rust Programming Language",
    "author": "Steve Klabnik",
    "isbn": "978-1718500440"
  }'

# List books
curl http://localhost:8001/api/books
```

### 3. Register with Hub

```bash
# Register Server A
curl -X POST http://localhost:8001/api/hub/register \
  -H "Content-Type: application/json" \
  -d '{"hub_url": "http://hub:80"}'

# Register Server B
curl -X POST http://localhost:8002/api/hub/register \
  -H "Content-Type: application/json" \
  -d '{"hub_url": "http://hub:80"}'
```

### 4. View Admin Dashboard

Open in browser: **http://localhost:8080/admin**

You should see both servers listed!

### 5. Test Peer Discovery

```bash
# From Server A, discover Server B
curl -X GET http://localhost:8001/api/hub/discover \
  -H "Content-Type: application/json" \
  -d '{"hub_url": "http://hub:80"}'
```

## 🛠️ Useful Commands

### View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f bibliogenius-a
docker-compose logs -f hub
```

### Restart Services

```bash
# Restart all
docker-compose restart

# Restart specific service
docker-compose restart bibliogenius-a
```

### Stop Services

```bash
# Stop all (keeps data)
docker-compose stop

# Stop and remove containers (keeps data)
docker-compose down

# Stop and remove everything including data
docker-compose down -v
```

### Rebuild After Code Changes

```bash
# Rebuild all images
docker-compose build

# Rebuild and restart
docker-compose up -d --build
```

### Access Container Shell

```bash
# Rust server
docker exec -it bibliogenius-a sh

# Symfony hub
docker exec -it bibliogenius-hub sh
```

## 📊 Service Details

### Rust Server A
- **Container**: bibliogenius-a
- **Port**: 8001
- **Database**: SQLite in volume `bibliogenius-a-data`
- **API**: http://localhost:8001/api/*

### Rust Server B
- **Container**: bibliogenius-b
- **Port**: 8002
- **Database**: SQLite in volume `bibliogenius-b-data`
- **API**: http://localhost:8002/api/*

### Symfony Hub (FrankenPHP)
- **Container**: bibliogenius-hub
- **Port**: 8080
- **Server**: FrankenPHP (modern PHP server with Caddy)
- **Database**: SQLite in `./bibliogenius-hub/var/data/hub.db`
- **Admin**: http://localhost:8080/admin
- **API**: http://localhost:8080/api/*

## 🔧 Troubleshooting

### Port Already in Use

If ports 8001, 8002, or 8080 are already in use, edit `docker-compose.yml`:

```yaml
ports:
  - "8001:8000"  # Change 8001 to another port
```

### Database Issues

```bash
# Reset Symfony hub database
docker exec -it bibliogenius-hub php bin/console doctrine:database:drop --force
docker exec -it bibliogenius-hub php bin/console doctrine:database:create
docker exec -it bibliogenius-hub php bin/console doctrine:schema:create
```

### Rebuild from Scratch

```bash
docker-compose down -v
docker-compose build --no-cache
docker-compose up -d
```

### View FrankenPHP Logs

```bash
docker-compose logs -f hub
```

## 🎯 Quick Test Script

```bash
#!/bin/bash

echo "🚀 Starting BiblioGenius POC..."
docker-compose up -d

echo "⏳ Waiting for services to start..."
sleep 10

echo "✅ Testing Rust Server A..."
curl -s http://localhost:8001/api/health | jq

echo "✅ Adding a book..."
curl -s -X POST http://localhost:8001/api/books \
  -H "Content-Type: application/json" \
  -d '{"title":"Test Book","author":"Test Author"}' | jq

echo "✅ Registering with hub..."
curl -s -X POST http://localhost:8001/api/hub/register \
  -H "Content-Type: application/json" \
  -d '{"hub_url":"http://hub:80"}' | jq

echo "🎉 POC is ready!"
echo "📊 Admin Dashboard: http://localhost:8080/admin"
```

## 📚 Documentation

- Full POC documentation: `../docs/POC_COMPLETE.md`
- Architecture diagrams: `../docs/ARCHITECTURE.md`
- Testing guide: `../docs/POC_ROADMAP.md`

---

**Status**: Ready to run with FrankenPHP! 🚀  
**Requirements**: Docker & Docker Compose only  
**No PHP/Composer/Nginx needed!** ✅

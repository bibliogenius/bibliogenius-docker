#!/bin/bash

echo "🚀 Starting BiblioGenius POC with FrankenPHP..."
docker-compose up -d

echo "⏳ Waiting for services to start..."
sleep 15

echo ""
echo "✅ Testing Rust Server A..."
curl -s http://localhost:8001/api/health | jq '.'

echo ""
echo "✅ Adding a test book..."
curl -s -X POST http://localhost:8001/api/books \
  -H "Content-Type: application/json" \
  -d '{"title":"The Rust Programming Language","author":"Steve Klabnik","isbn":"978-1718500440"}' | jq '.'

echo ""
echo "✅ Registering Server A with hub..."
curl -s -X POST http://localhost:8001/api/hub/register \
  -H "Content-Type: application/json" \
  -d '{"hub_url":"http://hub:80"}' | jq '.'

echo ""
echo "✅ Registering Server B with hub..."
curl -s -X POST http://localhost:8002/api/hub/register \
  -H "Content-Type: application/json" \
  -d '{"hub_url":"http://hub:80"}' | jq '.'

echo ""
echo "🎉 POC is ready!"
echo ""
echo "📊 Services:"
echo "   - Rust Server A: http://localhost:8001"
echo "   - Rust Server B: http://localhost:8002"
echo "   - Symfony Hub: http://localhost:8081"
echo "   - Admin Dashboard: http://localhost:8081/admin"
echo ""
echo "📚 View logs: docker-compose logs -f"
echo "🛑 Stop: docker-compose down"

go run ./cmd/encode/main.go "redis://localhost:6379"
go run ./cmd/decode/main.go secrets.json
eval $(go run ./cmd/decode/main.go secrets.json)

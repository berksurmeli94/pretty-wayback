package main

import (
	"encoding/json"
	"fmt"
	"os"
	"secret-manager/internal/crypto"
)

func main() {
	key := os.Getenv("SECRET_KEY")
	if len(key) != 32 {
		fmt.Fprintln(os.Stderr, "ERROR: SECRET_KEY must be 32 bytes")
		os.Exit(1)
	}

	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "Usage: decode <secrets.json>")
		os.Exit(1)
	}

	f, err := os.Open(os.Args[1])
	if err != nil {
		fmt.Fprintln(os.Stderr, "ERROR: Failed to open file:", err)
		os.Exit(1)
	}
	defer f.Close()

	var secrets map[string]string
	if err := json.NewDecoder(f).Decode(&secrets); err != nil {
		fmt.Fprintln(os.Stderr, "ERROR: Invalid JSON:", err)
		os.Exit(1)
	}

	for k, v := range secrets {
		val, err := crypto.Decrypt(v, key)
		if err != nil {
			fmt.Fprintf(os.Stderr, "ERROR: Failed to decrypt %s: %v\n", k, err)
			os.Exit(1)
		}
		fmt.Printf("export %s=%q\n", k, val)
	}
}

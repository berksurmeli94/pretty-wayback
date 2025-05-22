package main

import (
	"fmt"
	"os"
	"secret-manager/internal/crypto"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: encode <PLAINTEXT>")
		os.Exit(1)
	}

	plaintext := os.Args[1]
	key := os.Getenv("SECRET_KEY")

	enc, err := crypto.Encrypt(plaintext, key)
	if err != nil {
		fmt.Fprintln(os.Stderr, "Encrypt error:", err)
		os.Exit(1)
	}
	fmt.Println(enc)
}

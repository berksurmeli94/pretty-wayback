package crypto

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"encoding/base64"
	"errors"
	"fmt"
	"io"
)

func Encrypt(plaintext, key string) (string, error) {
	if len(key) != 32 {
		return "", errors.New("key must be 32 bytes for AES-256")
	}
	block, err := aes.NewCipher([]byte(key))
	if err != nil {
		return "", err
	}
	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		return "", err
	}
	nonce := make([]byte, 12)
	if _, err := io.ReadFull(rand.Reader, nonce); err != nil {
		return "", err
	}
	ciphertext := aesgcm.Seal(nil, nonce, []byte(plaintext), nil)
	return base64.StdEncoding.EncodeToString(append(nonce, ciphertext...)), nil
}

func Decrypt(encoded, key string) (string, error) {
	if len(key) != 32 {
		return "", errors.New("key must be 32 bytes for AES-256")
	}
	data, err := base64.StdEncoding.DecodeString(encoded)
	if err != nil {
		return "", err
	}
	if len(data) < 12 {
		return "", fmt.Errorf("ciphertext too short")
	}
	nonce := data[:12]
	ciphertext := data[12:]
	block, err := aes.NewCipher([]byte(key))
	if err != nil {
		return "", err
	}
	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		return "", err
	}
	plaintext, err := aesgcm.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		return "", err
	}
	return string(plaintext), nil
}

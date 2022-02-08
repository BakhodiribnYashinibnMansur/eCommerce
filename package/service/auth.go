package service

import (
	"crypto/sha1"
	"ecommercego/model"
	"ecommercego/package/repository"
	"errors"
	"fmt"
	"time"

	"github.com/dgrijalva/jwt-go"
)

const (
	salt       = "ud43ha43uo3tad43u98au877a8i676ao76u7ai678687ai87a6o6ei87a"
	tokenTTL   = 1024 * time.Hour
	signingKey = ("ea54eu%(U&u5U&6U^746%^U^75^io4yaU%63^aua34")
)

type tokenClaims struct {
	jwt.StandardClaims
	EmployeeID int `json:"employee_id"`
}
type AuthService struct {
	repo repository.Authorization
}

func NewAuthService(repo repository.Authorization) *AuthService {
	return &AuthService{repo: repo}
}

func (s *AuthService) CreateCompanyEmployee(admin model.CompEmployee) (int, error) {
	admin.Password = GeneratePasswordHash(admin.Password)
	return s.repo.CreateCompanyEmployee(admin)
}

func (s *AuthService) GenerateToken(username, password string) (string, error) {
	employee, err := s.repo.GetCompEmployee(username, GeneratePasswordHash(password))

	if err != nil {
		return "", err
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, &tokenClaims{
		jwt.StandardClaims{
			ExpiresAt: time.Now().Add(tokenTTL).Unix(),
			IssuedAt:  time.Now().Unix(),
		},
		employee.Id,
	})

	return token.SignedString([]byte(signingKey))
}

func GeneratePasswordHash(password string) string {
	hash := sha1.New()
	hash.Write([]byte(password))
	return fmt.Sprintf("%x", hash.Sum([]byte(salt)))
}

func (s *AuthService) ParseToken(accessToken string) (int, error) {
	token, err := jwt.ParseWithClaims(accessToken, &tokenClaims{}, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, errors.New("invalid signing method")
		}
		return []byte(signingKey), nil
	})

	if err != nil {
		return 0, err
	}
	claims, ok := token.Claims.(*tokenClaims)
	if !ok {
		return 0, errors.New("token claims are not of type *tokenClaims")
	}
	return claims.EmployeeID, nil
}

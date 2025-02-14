package config

import (
	"fmt"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"os"
)

func ConnectDatabase() *gorm.DB {
	host := os.Getenv("DB_HOST")
	if host == "" {
		host = "127.0.0.1"
	}
	port := os.Getenv("DB_PORT")
	if port == "" {
		port = "55432" 
	}
	user := os.Getenv("DB_USER")
	if user == "" {
		user = "myuser"
	}
	password := os.Getenv("DB_PASSWORD")
	if password == "" {
		password = "mypassword"
	}
	dbname := os.Getenv("DB_NAME")
	if dbname == "" {
		dbname = "kajitracker"
	}

	dsn := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		host, port, user, password, dbname)
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		panic("failed to connect database: " + err.Error())
	}

	db.AutoMigrate(&models.Kaji{}, &models.User{}, &models.KajiRecord{})

	return db
}
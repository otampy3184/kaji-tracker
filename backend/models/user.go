package models

import "time"

type User struct {
	ID          uint      `gorm:"primaryKey" json:"id"`
	UID         string    `gorm:"unique;not null" json:"uid"` // Google/Firebase UID
	Name        string    `json:"name"`
	Email       string    `json:"email"`
	PhotoURL    string    `json:"photo_url"`
	TotalPoints int       `gorm:"default:0" json:"total_points"`
	CreatedAt   time.Time `json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}
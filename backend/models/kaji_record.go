package models

import "time"

type KajiRecord struct {
	ID            uint      `gorm:"primaryKey" json:"id"`
	UserID        uint      `json:"user_id"`
	KajiID        uint      `json:"kaji_id"`
	PerformedDate time.Time `json:"performed_date"`
	CreatedAt     time.Time `json:"created_at"`
	UpdatedAt     time.Time `json:"updated_at"`
	
	// GORM のリレーション（必要に応じて）
	User User `json:"user"`
	Kaji Kaji `json:"kaji"`
}
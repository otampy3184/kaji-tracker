package controllers

import (
	"net/http"
	"backend/models"
	"backend/config"

	"github.com/gin-gonic/gin"
)

var DB = config.ConnectDatabase()

func GetKajis(c *gin.Context) {
	var kajis []models.Kaji
	if err := DB.Order("created_at desc").Find(&kajis).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, kajis)
}

func CreateKaji(c *gin.Context) {
	var input models.Kaji
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	kaji := models.Kaji{Title: input.Title, Content: input.Content, Points: input.Points}
	if err := DB.Create(&kaji).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusCreated, kaji)
}
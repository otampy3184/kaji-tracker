package controllers

import (
	"net/http"
	"backend/models"

	"github.com/gin-gonic/gin"
)

func GetKajiRecords(c *gin.Context) {
	var records []models.KajiRecord
	// JOIN を利用してユーザーや家事の情報も取得する場合は、Preload を利用できます
	if err := DB.Preload("User").Preload("Kaji").Order("performed_date desc").Find(&records).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, records)
}

func CreateKajiRecord(c *gin.Context) {
	var input models.KajiRecord
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	record := models.KajiRecord{
		UserID:        input.UserID,
		KajiID:        input.KajiID,
		PerformedDate: input.PerformedDate,
	}
	if err := DB.Create(&record).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusCreated, record)
}
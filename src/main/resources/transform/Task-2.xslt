<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Добавление "UNKNOWN" в пустые/отсутствующие атрибуты target_type -->
    <xsl:template match="@target_type[not(string-length(normalize-space()) > 0)]">
        <xsl:attribute name="target_type">UNKNOWN</xsl:attribute>
    </xsl:template>

    <!-- Копирование остальных узлов без изменений -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Основной шаблон для выборки узлов Object с четным ID -->
    <xsl:template match="/">
        <Objects>
            <!-- Выборка и сортировка узлов Object -->
            <xsl:apply-templates select="//Object[@ID mod 2 = 0]">
                <xsl:sort select="@ID" data-type="number" order="ascending"/>
            </xsl:apply-templates>
        </Objects>
    </xsl:template>

    <!-- Шаблон для копирования узлов Object -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
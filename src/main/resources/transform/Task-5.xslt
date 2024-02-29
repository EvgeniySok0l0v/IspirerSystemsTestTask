<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Основной шаблон для копирования всех узлов без изменений -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Шаблон для узлов Param с измененными атрибутами Name и pos -->
    <xsl:template match="Param[count(//Param[@Name = current()/@Name]) > 1 and not(@Name = preceding-sibling::Param/@Name)]">
        <Param>
            <xsl:attribute name="Name">
                <!-- Объединение значений атрибутов Name и pos -->
                <xsl:value-of select="concat(@Name, @pos)"/>
            </xsl:attribute>
            <xsl:attribute name="pos">
                <xsl:value-of select="@pos"/>
            </xsl:attribute>
            <!-- Копирование других атрибутов и содержимого -->
            <xsl:apply-templates select="@*[not(name() = 'Name' or name() = 'pos')] | node()"/>
        </Param>
    </xsl:template>

    <!-- Шаблон для копирования узлов Param без изменений -->
    <xsl:template match="Param[preceding-sibling::Param/@Name = current()/@Name]"/>

</xsl:stylesheet>

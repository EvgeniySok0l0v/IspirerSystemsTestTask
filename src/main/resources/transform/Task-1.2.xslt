<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Удаление пустых атрибутов java_package -->
    <xsl:template match="@java_package[not(string-length(normalize-space()) > 0)]" />

    <!-- Копирование остальных узлов без изменений -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
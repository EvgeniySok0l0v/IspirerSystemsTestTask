<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" encoding="UTF-8"/>

    <!-- Исключаем Procedure и Function без дочерних элементов -->
    <xsl:template match="Procedure[not(node())] | Function[not(node())]"/>

    <xsl:output method="xml" indent="no"/>

    <!-- Копируем остальные узлы без изменений -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes"/>

    <!-- Определение ключа для уникальных групп по атрибуту Name -->
    <xsl:key name="uniqueGroups" match="Function|Procedure" use="@Name"/>

    <!-- Основной шаблон для формирования и удаления повторяющихся групп -->
    <xsl:template match="/">
        <root>
            <!-- Формирование итерации FunctionGroup -->
            <xsl:apply-templates select="//Function[generate-id() = generate-id(key('uniqueGroups', @Name)[1])]" mode="firstIteration"/>

            <!-- Формирование итерации ProcedureGroup -->
            <xsl:apply-templates select="//Procedure[generate-id() = generate-id(key('uniqueGroups', @Name)[1])]" mode="firstIteration"/>
        </root>
    </xsl:template>

    <!-- Шаблон для копирования уникальных групп при первичной итерации -->
    <xsl:template match="Function|Procedure" mode="firstIteration">
        <!-- Проверка, что атрибут Name повторяется -->
        <xsl:if test="count(key('uniqueGroups', @Name)) > 1">
            <xsl:element name="{name()}Group">
                <xsl:attribute name="Name">
                    <xsl:value-of select="@Name"/>
                </xsl:attribute>
                <!-- Все узлы с этим именем -->
                <xsl:for-each select="key('uniqueGroups', @Name)">
                    <xsl:element name="{name()}">
                        <xsl:copy-of select="@* | node()"/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>

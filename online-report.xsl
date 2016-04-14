<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
								xmlns:xs="http://www.w3.og/2001/XMLSchema"
								exclude-result-prefixes="xs"
								version="2.0">

	<xsl:output encoding="UTF-8" method="text" omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="/">
		<xsl:apply-templates select="//titleStmt/title[1]"/>
		<xsl:apply-templates select="//sourceDesc[1]/bibl[1]/title"/>
	</xsl:template>

	<xsl:template match="//titleStmt/title[1]">
		<xsl:text>titleStmt apply-templates: </xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#10;</xsl:text>
		<xsl:text>titleStmt value-of: </xsl:text>
		<xsl:value-of select="normalize-space(.)"/>
		<xsl:text>&#10;</xsl:text>
	</xsl:template>

	<xsl:template match="//sourceDesc[1]/bibl[1]/title">
		<xsl:text>sourceDesc apply templates: </xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#10;</xsl:text>
		<xsl:text>sourceDesc value-of: </xsl:text>
		<xsl:value-of select="normalize-space(.)" />
		<xsl:text>&#10;</xsl:text>
	</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:param name="v_imageB64" />

	<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>

	<xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
	<xsl:template match="/">
		<xsl:apply-templates select="*" />
	</xsl:template>
	
	<xsl:template match="product">
		<product>
			<xsl:apply-templates select="*" />
			<imageB64><xsl:value-of select="$v_imageB64"></xsl:value-of></imageB64>
		</product>
	</xsl:template>
	
</xsl:stylesheet>
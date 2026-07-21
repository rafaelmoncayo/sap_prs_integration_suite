<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
	<xsl:template match="/">
	
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Product Catalog</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        .product-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .product-card {
            display: flex;
            align-items: center;
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }

        .product-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }

        .product-image {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 6px;
            margin-right: 10px;
            background-color: #eee;
        }

        .product-info {
            flex-grow: 1;
        }

        .product-name {
            margin: 0 0 5px 0;
            font-size: 1.2rem;
            color: #2c3e50;
        }

        .product-description {
            margin: 0;
            font-size: 0.9rem;
            color: #666;
        }

        .product-price {
            font-weight: bold;
            color: #27ae60;
            font-size: 1.1rem;
            margin-left: 20px;
        }

        @media (max-width: 480px) {
            .product-card {
                flex-direction: column;
                text-align: center;
            }
            .product-image {
                margin-right: 0;
                margin-bottom: 10px;
            }
            .product-price {
                margin-left: 0;
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Our Products</h1>
    
    <div class="product-list">
    
    	<xsl:for-each select="/products/product">
        <div class="product-card">
        	<!-- 
            <img src="https://picsum.photos/id/20/80/80" alt="Product 1" class="product-image"/>
             -->
            <xsl:variable name="imageSrc" select="concat('data:image/png;base64,', imageB64)" />
            <img src="{$imageSrc}" alt="Image" class="product-image"/>
            <div class="product-info">
                <h3 class="product-name">
                	<xsl:value-of select="name" />
                </h3>
                <p class="product-description"><xsl:value-of select="description"/>. Brand: <xsl:value-of select="brand"/></p>
            </div>
            <div class="product-price">$<xsl:value-of select="format-number(price, '###,###.00')"/></div>
        </div>
    	</xsl:for-each>
    
    </div>
</div>

</body>
</html>		
	</xsl:template>
</xsl:stylesheet>
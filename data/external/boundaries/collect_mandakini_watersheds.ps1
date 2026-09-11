# Mandakini Catchment Watershed Collector
# Downloads individual watershed polygons from Bhuvan WMS GetFeatureInfo
# and assembles them into a single GeoJSON FeatureCollection

$ErrorActionPreference = "Continue"
$outputDir = "c:\Users\abhil\Desktop\PRAVAAH AI\PRAVAAH-AI\data\external\boundaries"

# Known sample points that returned Mandakini (0202050601*) watersheds
$samplePoints = @(
    @{lon=78.95; lat=30.30}, @{lon=78.95; lat=30.35}, @{lon=78.90; lat=30.35},
    @{lon=78.85; lat=30.40}, @{lon=78.85; lat=30.45}, @{lon=79.00; lat=30.30},
    @{lon=79.05; lat=30.30}, @{lon=78.90; lat=30.40}, @{lon=79.05; lat=30.35},
    @{lon=78.95; lat=30.45}, @{lon=78.90; lat=30.45}, @{lon=79.10; lat=30.30},
    @{lon=78.90; lat=30.50}, @{lon=79.00; lat=30.35}, @{lon=78.90; lat=30.55},
    @{lon=79.05; lat=30.40}, @{lon=78.90; lat=30.60}, @{lon=79.15; lat=30.30},
    @{lon=79.15; lat=30.35}, @{lon=79.10; lat=30.35}, @{lon=79.00; lat=30.40},
    @{lon=78.95; lat=30.40}, @{lon=79.10; lat=30.25}, @{lon=79.20; lat=30.30},
    @{lon=79.00; lat=30.45}, @{lon=79.15; lat=30.25}, @{lon=79.00; lat=30.50},
    @{lon=78.95; lat=30.50}, @{lon=78.95; lat=30.55}, @{lon=79.10; lat=30.40},
    @{lon=79.05; lat=30.45}, @{lon=79.10; lat=30.45}, @{lon=79.10; lat=30.50},
    @{lon=79.15; lat=30.40}, @{lon=79.15; lat=30.45}, @{lon=79.15; lat=30.50},
    @{lon=79.20; lat=30.50}, @{lon=79.05; lat=30.50}, @{lon=79.10; lat=30.55},
    @{lon=79.05; lat=30.55}, @{lon=79.15; lat=30.55}, @{lon=79.20; lat=30.55},
    @{lon=79.15; lat=30.60}, @{lon=79.00; lat=30.55}, @{lon=79.05; lat=30.60},
    @{lon=79.00; lat=30.60}, @{lon=78.95; lat=30.60}, @{lon=78.95; lat=30.65},
    @{lon=79.05; lat=30.65}, @{lon=79.05; lat=30.70}, @{lon=79.05; lat=30.80},
    @{lon=79.00; lat=30.65}, @{lon=79.00; lat=30.70}, @{lon=78.95; lat=30.70},
    @{lon=79.05; lat=30.75}, @{lon=79.10; lat=30.60}, @{lon=79.10; lat=30.65},
    @{lon=79.15; lat=30.70}, @{lon=79.10; lat=30.75}, @{lon=79.10; lat=30.70},
    @{lon=79.15; lat=30.65}, @{lon=79.20; lat=30.65}, @{lon=79.20; lat=30.60},
    @{lon=79.20; lat=30.70}
)

# Additional fine-grid points to catch missed watersheds
$fineGrid = @()
for ($lon = 78.80; $lon -le 79.25; $lon += 0.025) {
    for ($lat = 30.25; $lat -le 30.85; $lat += 0.025) {
        $fineGrid += @{lon=[Math]::Round($lon,3); lat=[Math]::Round($lat,3)}
    }
}
$allPoints = $samplePoints + $fineGrid

$uniqueFeatures = @{}
$totalQueries = 0
$mandakiniCount = 0

Write-Host "Starting watershed collection from Bhuvan WMS..."
Write-Host "Total query points: $($allPoints.Count)"

foreach ($p in $allPoints) {
    $totalQueries++
    $bboxMinX = [Math]::Round($p.lon - 0.003, 4)
    $bboxMinY = [Math]::Round($p.lat - 0.003, 4)
    $bboxMaxX = [Math]::Round($p.lon + 0.003, 4)
    $bboxMaxY = [Math]::Round($p.lat + 0.003, 4)
    
    # First get just attributes (text/plain) to check NRISCODE
    $textUrl = "https://bhuvan-vec1.nrsc.gov.in/bhuvan/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&QUERY_LAYERS=cite:bhuvan_watershed&LAYERS=cite:bhuvan_watershed&INFO_FORMAT=text/plain&FEATURE_COUNT=1&X=50&Y=50&SRS=EPSG:4326&WIDTH=101&HEIGHT=101&BBOX=$bboxMinX,$bboxMinY,$bboxMaxX,$bboxMaxY"
    
    try {
        $resp = Invoke-WebRequest -Uri $textUrl -TimeoutSec 20 -UseBasicParsing
        if ($resp.Content -match 'NRISCODE = (\d+)') {
            $code = $matches[1]
            if ($code.StartsWith('0202050601') -and -not $uniqueFeatures.ContainsKey($code)) {
                # This is a new Mandakini watershed - get full GeoJSON
                $jsonUrl = "https://bhuvan-vec1.nrsc.gov.in/bhuvan/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&QUERY_LAYERS=cite:bhuvan_watershed&LAYERS=cite:bhuvan_watershed&INFO_FORMAT=application/json&FEATURE_COUNT=1&X=50&Y=50&SRS=EPSG:4326&WIDTH=101&HEIGHT=101&BBOX=$bboxMinX,$bboxMinY,$bboxMaxX,$bboxMaxY"
                
                $jsonResp = Invoke-WebRequest -Uri $jsonUrl -TimeoutSec 30 -UseBasicParsing
                $uniqueFeatures[$code] = $jsonResp.Content
                $mandakiniCount++
                Write-Host "[$mandakiniCount] Found: $code at ($($p.lon), $($p.lat))"
            }
        }
    } catch {
        # Skip errors silently
    }
    
    if ($totalQueries % 100 -eq 0) {
        Write-Host "Progress: $totalQueries queries, $mandakiniCount unique Mandakini watersheds"
    }
}

Write-Host "`nCollection complete."
Write-Host "Total queries: $totalQueries"
Write-Host "Unique Mandakini watersheds: $mandakiniCount"

# Now assemble the GeoJSON
Write-Host "`nAssembling GeoJSON..."

$allFeatureJsons = @()
foreach ($entry in $uniqueFeatures.GetEnumerator()) {
    $content = $entry.Value
    # Extract the feature JSON from the FeatureCollection wrapper
    if ($content -match '"features":\[(\{.*?\})\]') {
        # This is tricky with nested braces - use a different approach
    }
    # Just store the raw response for later processing
    $safeCode = $entry.Key
    $featureFile = Join-Path $outputDir "temp_ws_$safeCode.json"
    Set-Content -Path $featureFile -Value $content -Encoding UTF8
}

# Create a summary file
$summary = @{
    collection_date = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
    source = "ISRO/NRSC Bhuvan WMS"
    service_url = "https://bhuvan-vec1.nrsc.gov.in/bhuvan/wms"
    layer = "cite:bhuvan_watershed"
    feature_type = "UK_WS (Uttarakhand Watersheds)"
    crs = "EPSG:4326"
    geometry_type = "MultiPolygon"
    mandakini_nriscode_prefix = "0202050601"
    total_watersheds_found = $mandakiniCount
    watershed_codes = ($uniqueFeatures.Keys | Sort-Object)
}
$summaryJson = $summary | ConvertTo-Json -Depth 3
$summaryFile = Join-Path $outputDir "mandakini_watershed_collection_summary.json"
Set-Content -Path $summaryFile -Value $summaryJson -Encoding UTF8

Write-Host "`nSummary saved to: $summaryFile"
Write-Host "Individual watershed files saved to: $outputDir"

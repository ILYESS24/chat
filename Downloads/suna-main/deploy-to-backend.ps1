# Script to deploy React build to backend/static
Write-Host "Building React app..." -ForegroundColor Green
npm run build

Write-Host "Copying files to backend/static..." -ForegroundColor Green
if (Test-Path "dist") {
    # Copy all files from dist to backend/static
    Copy-Item -Path "dist/*" -Destination "backend/static/" -Recurse -Force
    Write-Host "✅ React interface deployed to backend/static/" -ForegroundColor Green
} else {
    Write-Host "❌ Build failed - no dist directory found" -ForegroundColor Red
}

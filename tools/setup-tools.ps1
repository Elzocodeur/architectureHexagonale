Write-Host "Initializing development tools setup..." -ForegroundColor Cyan

# Creer la structure des dossiers
$folders = @(
    "tools/templates",
    "src/modules",
    "src/core/config",
    "src/core/constants",
    "src/core/decorators",
    "src/core/exceptions",
    "src/core/guards",
    "src/core/interfaces",
    "src/core/middlewares",
    "src/core/utils"
)

foreach ($folder in $folders) {
    if (!(Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
        Write-Host "  Created: $folder" -ForegroundColor Green
    }
}

# Installer les dependances necessaires
Write-Host "Installing required dependencies..." -ForegroundColor Cyan
npm install --save-dev ts-node rimraf @compodoc/compodoc

# Creer le fichier de configuration
$configContent = @'
export default () => ({
  port: parseInt(process.env.PORT, 10) || 3000,
  database: {
    url: process.env.DATABASE_URL
  },
  jwt: {
    secret: process.env.JWT_SECRET,
  }
});
'@

$configPath = "src/core/config/configuration.ts"
if (!(Test-Path $configPath)) {
    Set-Content -Path $configPath -Value $configContent
    Write-Host "  Created: $configPath" -ForegroundColor Green
}

# Creer les constants
$constantsContent = @'
export const MESSAGES = {
  UNAUTHORIZED: 'Unauthorized access',
  FORBIDDEN: 'Forbidden resource',
  NOT_FOUND: 'Resource not found'
};
'@

$constantsPath = "src/core/constants/index.ts"
if (!(Test-Path $constantsPath)) {
    Set-Content -Path $constantsPath -Value $constantsContent
    Write-Host "  Created: $constantsPath" -ForegroundColor Green
}

# Creer l'exception de base
$exceptionContent = @'
import { HttpException, HttpStatus } from '@nestjs/common';

export class BaseException extends HttpException {
  constructor(message: string, status: HttpStatus) {
    super(message, status);
  }
}
'@

$exceptionPath = "src/core/exceptions/base.exception.ts"
if (!(Test-Path $exceptionPath)) {
    Set-Content -Path $exceptionPath -Value $exceptionContent
    Write-Host "  Created: $exceptionPath" -ForegroundColor Green
}

Write-Host ""
Write-Host "Development tools setup completed!" -ForegroundColor Green
Write-Host "You can now use the following commands:" -ForegroundColor Yellow
Write-Host "   - npm run generate:module <module-name>"
Write-Host "   - npm run build"
Write-Host "   - npm run dev"

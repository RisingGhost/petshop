# Определяем выходной файл
$outputFile = "all_progect_files.txt"

# Удаляем выходной файл, если он уже существует
if (Test-Path $outputFile) {
    Remove-Item $outputFile
}

# Список расширений (50 самых популярных)
$extensions = @(
    "*.txt", "*.md", "*.markdown", "*.html", "*.css", "*.scss", "*.less",
    "*.js", "*.ts", "*.jsx", "*.tsx", "*.json", "*.xml",
    "*.yaml", "*.yml", "*.ini", "*.cfg", "*.conf",
    "*.py", "*.java", "*.c", "*.cpp", "*.h", "*.cs",
    "*.php", "*.rb", "*.go", "*.rs", "*.swift", "*.kt",
    "*.dart", "*.sh", "*.bat", "*.cmd", "*.ps1", "*.pl",
    "*.sql", "*.csv", "*.tsv", "*.scss", "*.less", "*.coffee",
    "*.vue", "*.svelte", "*.jsx", "*.tsx", "*.xhtml", "*.tex",
    "*.r", "*.erl", "*.hs", "*.scala", "*.ps1", "*.vb"
)

# Список файлов без расширений
$filesWithoutExtensions = @(
    "Dockerfile", "dockerfile", "Makefile", "makefile", "README", "LICENSE",
    ".gitignore", ".gitattributes", "Procfile", "Vagrantfile", "Jenkinsfile",
    "Rakefile", "Gemfile", ".editorconfig", ".eslintrc", ".prettierrc",
    ".stylelintrc", ".npmrc", ".env", ".babelrc", "package.json", "composer.json",
    "Pipfile", "requirements.txt", "yarn.lock", "Gemfile.lock", "Cargo.toml",
    "Cargo.lock", "build.gradle", "pom.xml", "CMakeLists.txt", "webpack.config.js"
)

# Ищем файлы с заданными расширениями
Get-ChildItem -Path . -Recurse -Include $extensions -File | ForEach-Object {
    Write-Output "===== $($_.FullName) =====" | Out-File -FilePath $outputFile -Append -Encoding UTF8
    Get-Content -Path $_.FullName -Encoding UTF8 | Out-File -FilePath $outputFile -Append -Encoding UTF8
    "`n`n`n" | Out-File -FilePath $outputFile -Append -Encoding UTF8
}

# Ищем файлы без расширений по именам
Get-ChildItem -Path . -Recurse -File | Where-Object {
    $filesWithoutExtensions -contains $_.Name
} | ForEach-Object {
    Write-Output "===== $($_.FullName) =====" | Out-File -FilePath $outputFile -Append -Encoding UTF8
    Get-Content -Path $_.FullName -Encoding UTF8 | Out-File -FilePath $outputFile -Append -Encoding UTF8
    "`n`n`n" | Out-File -FilePath $outputFile -Append -Encoding UTF8
}

Write-Host "Все файлы объединены в $outputFile "PetShop"

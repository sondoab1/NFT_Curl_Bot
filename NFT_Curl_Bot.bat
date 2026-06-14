@echo off
chcp 65001 > nul
title NFT Curl Bot - Task 6

echo ============================================
echo NFT Curl Bot - Task 6
echo ============================================
echo.

echo [1] Date from timeanddate.com
curl -L -s https://www.timeanddate.com/ > timeanddate.html
powershell -Command "$html = Get-Content 'timeanddate.html' -Raw; if ($html -match '<span id=\"ij2\">([^<]+)</span>') { Write-Host 'Date:' $matches[1] } else { Write-Host 'Date not found' }"
echo.

echo [2] IP address from whatismyip.com
curl -L -s https://www.whatismyip.com/ > whatismyip.html
powershell -Command "$ip = (curl.exe -s https://api.ipify.org); if ($ip) { Write-Host 'IP:' $ip } else { Write-Host 'IP not found' }"
echo.

echo [3] Main headline from ynet.co.il
curl -L -s https://www.ynet.co.il > ynet.html
powershell -Command "$html = Get-Content 'ynet.html' -Raw -Encoding UTF8; if ($html -match '<title>(.*?)</title>') { Write-Host 'Headline:' $matches[1] } else { Write-Host 'Headline not found' }"
echo.

echo [4] Download link from bugzilla.org
curl -L -s https://www.bugzilla.org > bugzilla.html
powershell -Command "$html = Get-Content 'bugzilla.html' -Raw; if ($html -match 'https://www\.bugzilla\.org/download/') { Write-Host 'Download Link: https://www.bugzilla.org/download/' } else { Write-Host 'Link not found' }"
echo.

echo [5] First tutorial from jmeter.apache.org
curl -L -s https://jmeter.apache.org > jmeter.html
powershell -Command "$html = Get-Content 'jmeter.html' -Raw; if ($html -match 'jmeter_distributed_testing_step_by_step\.html[^>]*>([^<]+)</a>') { Write-Host 'First Tutorial:' $matches[1]; Write-Host 'Tutorial Link: https://jmeter.apache.org/usermanual/jmeter_distributed_testing_step_by_step.html' } else { Write-Host 'Tutorial not found' }"
echo.

echo [6] NFT course students from moodle.sce.ac.il
powershell -Command "$html = (Get-Content 'moodle_participants.html' -Raw -Encoding UTF8) + (Get-Content 'moodle_participants_page2.html' -Raw -Encoding UTF8); $matches = [regex]::Matches($html, 'בחירת ''([^'']+)'''); $names = $matches | ForEach-Object { $_.Groups[1].Value.Trim() } | Where-Object { $_ -ne 'שי גינזבורג' } | Sort-Object -Unique; $names | Out-File 'moodle_students.txt' -Encoding UTF8; Write-Host ('Students Found: ' + $names.Count); $names"
echo.

echo [7] NFT jobs from linkedin.com
curl -L -s "https://www.linkedin.com/jobs/search/?keywords=NFT" > linkedin.html

powershell -Command "$html = Get-Content 'linkedin.html' -Raw -Encoding UTF8; $matches = [regex]::Matches($html, 'base-search-card__title[^>]*>(.*?)</h3>', 'Singleline'); $jobs = $matches | ForEach-Object { ($_.Groups[1].Value -replace '<[^>]+>', '').Trim() } | Where-Object { $_ -ne '' } | Select-Object -First 10; $jobs | Out-File 'linkedin_jobs.txt' -Encoding UTF8; Write-Host ('Jobs Found: ' + $jobs.Count); $jobs"
echo.
echo [8] Software non functional testing books from Amazon

powershell -Command "$html = Get-Content 'amazon_books.html' -Raw -Encoding UTF8; $matches = [regex]::Matches($html, '<h2[^>]*>(.*?)</h2>', 'Singleline'); $books = $matches | ForEach-Object { ($_.Groups[1].Value -replace '<[^>]+>', '').Trim() } | Where-Object { $_ -ne '' -and $_ -notmatch 'תוצאות|לדלג|מקשי|software non functional testing' } | Select-Object -First 10; $books | Out-File 'amazon_books.txt' -Encoding UTF8; Write-Host ('Books Found: ' + $books.Count); $books"

echo.
pause
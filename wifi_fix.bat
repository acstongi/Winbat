@echo off
title All-in-One Network Fixer
echo ===========================================
echo Network Troubleshooting Script for Win 7-11
echo ===========================================
echo.

:: আইপি রিলিজ এবং রিনিউ করা
echo 1. Releasing and Renewing IP Address...
ipconfig /release
ipconfig /renew

:: ডিএনএস ক্যাশ পরিষ্কার করা
echo 2. Flushing DNS...
ipconfig /flushdns

:: নেটওয়ার্ক স্ট্যাক রিসেট করা
echo 3. Resetting Winsock and IP Stack...
netsh winsock reset
netsh int ip reset

:: এআরপি টেবিল এবং রুট টেবিল রিসেট (ঐচ্ছিক কিন্তু কার্যকরী)
echo 4. Clearing ARP table...
arp -d *

echo.
echo ===========================================
echo কাজ শেষ! আপনার পিসিটি একবার রিস্টার্ট দিন।
echo ===========================================
pause
exit

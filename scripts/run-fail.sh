#!/usr/bin/env bash
# FAIL хувилбарыг ажиллуулж, k6-ийн exit code-ыг (tee-гийнх биш) файлд тэмдэглэнэ.
# CI pipeline яг энэ exit code-оор build-ийг зогсоодог (threshold зөрчигдвөл 99).
mkdir -p results
k6 run slo-test-fail.js 2>&1 | tee results/fail.txt
rc=${PIPESTATUS[0]}
echo "exit=$rc" | tee -a results/fail.txt

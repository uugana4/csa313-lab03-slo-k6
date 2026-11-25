#!/usr/bin/env bash
# Мини chaos туршилт: 2 минутын тестийн дундуур серверийг 10 секунд зогсоогоод дахин асаана.
# Урьдчилсан нөхцөл: өөр terminal дээр server.js АЖИЛЛАЖ БАЙХГҮЙ байх (3000 порт чөлөөтэй).
# Гаралт: results/chaos.txt (k6), results/chaos-timeline.txt (зогсолтын цаг), results/server-chaos.log
mkdir -p results
: > results/chaos-timeline.txt

node server.js > results/server-chaos.log 2>&1 &
SRV=$!
sleep 2

echo "[$(date +%T)] k6 эхэллээ (2 минут)" | tee -a results/chaos-timeline.txt
k6 run --duration 2m slo-test.js > results/chaos.txt 2>&1 &
K6=$!

sleep 40
echo "[$(date +%T)] сервер ЗОГСООНО" | tee -a results/chaos-timeline.txt
kill $SRV
wait $SRV 2>/dev/null

sleep 10
echo "[$(date +%T)] сервер ДАХИН АСААЛАА (10 секундын зогсолт)" | tee -a results/chaos-timeline.txt
node server.js >> results/server-chaos.log 2>&1 &
SRV=$!

wait $K6
rc=$?
echo "[$(date +%T)] k6 дууслаа, exit=$rc" | tee -a results/chaos-timeline.txt
kill $SRV 2>/dev/null
wait $SRV 2>/dev/null
echo "Дууслаа. Гаралт: results/chaos.txt"

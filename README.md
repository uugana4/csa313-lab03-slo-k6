# Лаб 3: Чанарын сценарио -> SLO -> k6 threshold (F.CSA313)

**Оюутан:** А.Ууганбаяр (B242270014)

Өөрийн локал API-д зориулж performance, reliability, availability сценарио бичиж, SLO болгон томьёолж, k6 threshold-оор автоматаар шалгуулна.

## Ёс зүй
Бүх load тестийг зөвхөн өөрийн компьютер дээрх локал сервер (`http://localhost:3000`) рүү хийсэн.

## Файлууд
| Файл | Зорилго |
|---|---|
| `server.js` | Тестлэх локал API (`/cart/add`, `/report`, `/pay`) |
| `slo-test.js` | SLO-г k6 threshold болгон кодчилсон тест |
| `slo-test-fail.js` | Threshold-ыг зориуд эвдсэн (FAIL) хувилбар |
| `scripts/run-fail.sh` | FAIL хувилбарыг ажиллуулж exit code-ыг тэмдэглэнэ |
| `scripts/chaos.sh` | 10 секундын зогсолттой chaos туршилт |
| `results/` | k6-ийн бүтэн текст гаралтууд |
| `screenshots/` | Дэлгэцийн зургууд |

## Ажиллуулах
```bash
npm install
node server.js                                  # нэг terminal дээр

k6 run slo-test.js 2>&1 | tee results/pass.txt  # PASS
bash scripts/chaos.sh                           # chaos (server.js-ийг зогсоосон байх)
bash scripts/run-fail.sh                        # FAIL + exit code
```

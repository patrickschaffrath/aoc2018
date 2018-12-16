# aoc2018

## Parsing of inputs:
Use
```
curl -sb session=<token> https://adventofcode.com/2018/day/<day>/input
```
with valid \<token> and \<day>, then pipe with `sed` command of the day.

### Day1
```bash
sed ':a;N;$!ba;s/\n/,\n\x20\x20/g;s/\+//g;s/^/input =\n\x20\x20\[/;s/$/\]/' > /dev/clipboard
```

### Day2
```bash
sed -E ':a;N;$!ba;s/([[:lower:]])/\x27\1\x27,/g;s/,\n/\],\n\x20\x20\[/g;s/^/input =\n\x20\x20\[\[/;s/,$/\]\]/' > /dev/clipboard
```

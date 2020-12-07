BCD_MAP = [
  "0000",
  "0001",
  "0010",
  "0011",
  "0100",
  "0101",
  "0110",
  "0111",
  "1000",
  "1001",
  "1010",
  "1011",
  "1100",
  "1101",
  "1110",
  "1111",
]

result = []

for i in range(10000):
  num = i
  bcd = ""

  for _ in range(4):
    bcd = BCD_MAP[num % 10] + bcd
    num = num // 10

  result.append(bcd)

with open('bcdRom.mem', 'w') as f:
  f.write('\n'.join(result))

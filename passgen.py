#!/usr/bin/python3

import random

s = list(map(chr,range(ord('a'),ord('z'))))
s += list(map(chr,range(ord('A'),ord('Z'))))
s += list(map(chr,range(ord('0'),ord('9'))))
r=s
random.shuffle(r)


print("".join(r[:12]))
